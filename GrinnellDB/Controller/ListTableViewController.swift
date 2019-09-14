//
//  ListTableViewController.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/10/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return CGFloat(123.0)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = people[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as? ResultTableViewCell {
            cell.name.text = person.firstName + " " + person.lastName
            cell.profileImage.image = UIImage(named: "ZixuanGuo")
            return cell
        }
        
        return UITableViewCell()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
