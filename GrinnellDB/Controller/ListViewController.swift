//
//  ListTableViewController.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/10/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetch(at: 1)
    }
    
    // MARK: - Query
    
    var params: [String: String?] = [:]
    let defaults = UserDefaults.standard
    
    var currentPage: Int = 1
    var maxPage: Int = 1
    var isLoadingList: Bool = false // you do not want to load twice
    
    func fetch(at page: Int) {
        guard let cookie = defaults.string(forKey: "cookie") else { return }
        
        /* translate parameters to query dictionary */
        let query: [String: String] = ["firstName": (params["First name"] ?? "") ?? "" ,
                                       "lastName" : (params["Last name"] ?? "") ?? "",
                                       "email": (params["Computer Username"] ?? "") ?? "",
                                       "campusPhone": (params["Campus Phone"] ?? "") ?? "",
                                       "homeAddress": (params["Home Address"] ?? "") ?? "",
                                       "facultyDepartment": (params["Fac/Staff Dept/Office"] ?? "") ?? "",
                                       "major": (params["Student Major"] ?? "") ?? "",
                                       "concentration": (params["Concentration"] ?? "") ?? "",
                                       "sga": (params["SGA"] ?? "") ?? "",
                                       "hiatus": (params["Hiatus"] ?? "") ?? "",
                                       "studentClass": (params["Student Class"] ?? "") ?? "",
                                       "campusquery": (params["Campus Address or P.O. Box"] ?? "") ?? "",
                                       "token": cookie]
       
        var searchURLComponents = URLComponents(string: "https://appdev.grinnell.edu/api/db/v1/fetch?")
           
        /* search parameters */
        var querys: [URLQueryItem] = []
        for (key, value) in query {
            querys.append(URLQueryItem(name: key, value: value))
        }
        
        /* page to fetch */
        querys.append(URLQueryItem(name: "page", value: String(page)))

        searchURLComponents?.queryItems = querys
        let url = searchURLComponents!.url!
        
        print("URLLLLLLL \(url)")
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { // no internet connection
                DispatchQueue.main.async {
                    self.tableView.setErrorMessage("No internet connection. Make sure you connect to Grinnell College's network")
                }
                return
            }
            
            do {
                let results = try JSONDecoder().decode(QueryResult.self, from: data)

                if let maxPage = results.maximumPage {
                    self.maxPage = maxPage
                }
                
                if results.status == 400 { // too many people
                    DispatchQueue.main.async {
                        self.tableView.setErrorMessage("Found too many people, please narrow the range")
                    }
                } else if results.status == 401 { // cookie expire
                    DispatchQueue.main.async {
                        self.tableView.setErrorMessage("Cookie expired, please try again")
                    }
                } else { // successful query
                    if let contents = results.content {
                        if contents.count > 0 {
                            for person in contents {
                                if let student = person as? Student {
                                    self.people.append(student)
                                } else if let faculty = person as? Faculty {
                                    self.people.append(faculty)
                                } else if let sga = person as? SGA {
                                    self.people.append(sga)
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.tableView.setErrorMessage("Your query found no matches")
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } else { // unknown bug
                        DispatchQueue.main.async {
                            self.tableView.setErrorMessage("Unknown error")
                        }
                    }
                }
            } catch let jsonerr {
                print(jsonerr)
                DispatchQueue.main.async {
                    self.tableView.setErrorMessage(String(decoding: data, as: UTF8.self))
                    //self.navigationController?.popToRootViewController(animated: true)
                }
                
            }
        }.resume()
        
        self.isLoadingList = false // finish loading
    }

    // MARK: - Table view data source
    
    var people: [Person] = []
    var imageCache: [Int: UIImage] = [:]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(144.5)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = people[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as? ResultTableViewCell {
            /* load name and description */
            let detailText: String
            switch person.type {
            case .student:
                let student = person as! Student
                detailText = "\(student.email ?? "Null")\n\(student.major ?? "Null")\n\(student.classYear ?? "Null")\n"
            case .SGA:
                let sga = person as! SGA
                detailText = "\(sga.email ?? "Null")\n\(sga.positionName ?? "Null")\n"
            case .faculty:
                let faculty = person as! Faculty
                detailText = "\(faculty.email ?? "Null")\n\(faculty.department ?? "Null")\n\(faculty.title ?? "Null")\n"
            }
                        
            cell.name.text = (person.firstName ?? "") + " " + (person.lastName ?? "")
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 2.0
            var attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0),
                              NSAttributedString.Key.paragraphStyle: paragraphStyle]
            // support dark mode
            if #available(iOS 13.0, *) {
                attributes[NSAttributedString.Key.foregroundColor] = UIColor.secondaryLabel
            } else {
                attributes[NSAttributedString.Key.foregroundColor] = UIColor.black
            }
            cell.detail.attributedText = NSAttributedString(string: detailText, attributes: attributes)
            cell.detail.textContainer.lineBreakMode = .byCharWrapping
            
            /* load image */
            if let image = imageCache[indexPath.row] {
                cell.profileImage?.image = image
            } else {
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    let urlContents = try? Data(contentsOf: URL(string: person.imgPath ?? "https://itwebapps.grinnell.edu/PcardImages/moved/link/gone.jpg")!)
                    DispatchQueue.main.async {
                        if let imageData = urlContents {
                            cell.profileImage?.image = UIImage(data: imageData)
                            self?.imageCache[indexPath.row] = UIImage(data: imageData)
                            cell.profileImage?.contentMode = .scaleToFill
                            //self?.tableView.reloadRows(at: [indexPath], with: .automatic)
                        }
                    }
                }
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    /* pagination */
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !isLoadingList && (indexPath.row == people.count - 1) && (currentPage < maxPage) {
            isLoadingList = true
            fetch(at: currentPage + 1)
            currentPage += 1
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController, let cell = sender as? UITableViewCell {
            if let selectedIndexPath = tableView.indexPath(for: cell) {
                detailVC.person = people[selectedIndexPath.row]
                detailVC.profileImage = imageCache[selectedIndexPath.row] ?? UIImage(named: "placeholder")
            }
        }
    }
}

/* DEBUGGING: for displaying JSON */
extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

/* display error message */
extension UITableView {
    func setErrorMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        messageLabel.numberOfLines = 0

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
