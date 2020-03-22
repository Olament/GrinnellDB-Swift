//
//  DetailViewController.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/20/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import UIKit
import MessageUI

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var label: [(String, String)] = []
    var height: [Double] = []
    
    var person: Person?
    var profileImage: UIImage?
    
    let defaults = UserDefaults.standard // default storage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let student = person as? Student {
            label = [("Major", student.major ?? "Null"),
                     ("Class", student.classYear ?? "Null"),
                     ("Email", student.email ?? "Null"),
                     ("Campus Box", student.box ?? "Null"),
                     ("Campus Address", student.address ?? "Null")]
        } else if let faculty = person as? Faculty {            
            label = [("Titles", faculty.title ?? "Null"),
                     ("Departments", faculty.department ?? "Null"),
                     ("Campus Phone", faculty.phone ?? "Null"),
                     ("Email", faculty.email ?? "Null"),
                     ("Campus Address", faculty.address ?? "Null"),
                     ("Campus Box", faculty.box ?? "Null")]
        } else if let sga = person as? SGA {
            let officeHours = sga.officeHours
            
            label = [("SGA Position", sga.positionName ?? "Null"),
                     ("Office Email", sga.officeEmail ?? "Null"),
                     ("Office Hours", officeHours ?? "Null"),
                     ("Major", sga.major ?? "Null"),
                     ("Class", sga.classYear ?? "Null"),
                     ("Email", sga.email ?? "Null"),
                     ("Campus Box", sga.box ?? "Null"),
                     ("Office address", sga.officeAddress ?? "Null"),
                     ("SGA Phone", sga.officePhone ?? "Null"),
                     ("SGA Box", sga.officeBox ?? "Null")]
        }
        
            fetch()
    }
    
    // MARK: - Detail view JSON fetch
    
    func fetch() {
        guard let cookie = defaults.string(forKey: "cookie") else { return }
        
        var searchURLComponents = URLComponents(string: "https://appdev.grinnell.edu/api/db/v1/person?")
        
        var querys: [URLQueryItem] = []
        querys.append(URLQueryItem(name: "username", value: person?.userName))
        querys.append(URLQueryItem(name: "token", value: cookie))
            
        searchURLComponents?.queryItems = querys
        let url = searchURLComponents!.url!
        
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            
            do {
                
                switch self.person!.type {
                case .faculty:
                    let result = try JSONDecoder().decode(facultyDetail.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.label.append(("Home Address", result.homeAddress))
                        self.label.append(("Spouse/Partner", result.spouse))
                        self.label.append(("Home Phone", result.homePhone))
                        
                        self.tableView.reloadData()
                    }
                case .student, .SGA:
                    let result = try JSONDecoder().decode(studentDetail.self, from: data)
                    
                    DispatchQueue.main.async {
                        if let concentration = result.concentration {
                            self.label.append(("Concentration", concentration))
                        }
                        if let homeAddress = result.homeAddress {
                            self.label.append(("Home Address", homeAddress))
                        }
                        
                        self.tableView.reloadData()
                    }
                }
            } catch let jsonerr {
                print(jsonerr)
            }
        }.resume()
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return label.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0, let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as? ProfileTableViewCell {
            cell.profileImage.image = self.profileImage
            cell.name.text = (person?.firstName ?? "") + " " + (person?.lastName ?? "")
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "attributeCell", for: indexPath) as? AttributeTableViewCell {
            let text = label[indexPath.row - 1]
            cell.title.text = text.0
            cell.subtitle.text = text.1
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(210.0)
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(210.0)
        }
        
        return UITableView.automaticDimension
    }
    
    /* sending message */
    @IBAction func sendMessage(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([person?.email ?? "Null"])
            
            present(mail, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
