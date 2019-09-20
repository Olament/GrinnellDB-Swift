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
                detailText = String(format: "%@\n%@\n%@", student.email, student.major, student.classYear)
            case .SGA:
                let sga = person as! SGA
                detailText = String(format: "%@\n%@\n", sga.email, sga.positionName)
            case .faculty:
                let faculty = person as! Faculty
                detailText = String(format: "%@\n%@\n%@", faculty.email, faculty.departments[0], faculty.titles[0])
            }
            
            cell.name.text = person.firstName + " " + person.lastName
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 8.0
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0),
                              NSAttributedString.Key.paragraphStyle: paragraphStyle]
            cell.detail.attributedText = NSAttributedString(string: detailText, attributes: attributes)
            
            
            /* load image */
            if let image = imageCache[indexPath.row] {
                cell.profileImage?.image = image
            } else {
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    let urlContents = try? Data(contentsOf: person.imgPath)
                    DispatchQueue.main.async {
                        if let imageData = urlContents {
                            cell.profileImage?.image = UIImage(data: imageData)
                            self?.imageCache[indexPath.row] = UIImage(data: imageData)
                            cell.profileImage?.contentMode = .scaleToFill
                            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
                        }
                    }
                }
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController, let cell = sender as? UITableViewCell {
            if let selectedIndexPath = tableView.indexPath(for: cell) {
                detailVC.person = people[selectedIndexPath.row]
                detailVC.profileImage = imageCache[selectedIndexPath.row]
            }
        }
    }
}
