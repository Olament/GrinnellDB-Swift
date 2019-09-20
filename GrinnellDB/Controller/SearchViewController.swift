//
//  SearchTableViewController.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/7/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    
    let searchFieldSimple: [String] = ["First name",
                                       "Last name"]
    let searchFieldDetail: [String] = ["Campus Address or P.O. Box",
                                       "Fac/Staff Dept/Office",
                                       "Student Major",
                                       "Hiatus",
                                       "Computer Username",
                                       "Campus Phone",
                                       "Home Address",
                                       "SGA",
                                       "Concentration"] // delete student class temporary
    
    let optionToCellType: [String: String] = ["First name": "TextCell",
                                              "Last name": "TextCell",
                                              "Campus Address or P.O. Box": "TextCell",
                                              "Fac/Staff Dept/Office": "PickerCell",
                                              "Student Major": "PickerCell",
                                              "Hiatus": "PickerCell",
                                              "Computer Username": "TextCell",
                                              "Campus Phone": "NumberCell",
                                              "Home Address": "TextCell",
                                              "SGA": "PickerCell",
                                              "Concentration": "PickerCell",
                                              "Student Class": "PickerCell"]
    
    /* data for each option */
    let major: [String] = ["None",
                           "Anthropology",
                           "Art History",
                           "Biological Chemistry",
                           "Biology",
                           "Chemistry",
                           "Chinese",
                           "Classics",
                           "Computer Science",
                           "Economics",
                           "English",
                           "French",
                           "Gender, Women's and Sexuality Studies",
                           "General Science",
                           "German",
                           "History",
                           "Mathematics",
                           "Music",
                           "Philosophy",
                           "Physics",
                           "Political Science",
                           "Psychology",
                           "Religious Studies",
                           "Russian",
                           "Sociology",
                           "Spanish",
                           "Studio Art",
                           "Theatre and Dance"]
    let department: [String] = ["None",
                                "Academic Advising",
                                "Academic Affairs and Dean of the College",
                                "Accessibility and Disability Services",
                                "Accounting",
                                "Admission",
                                "Analytic Support and Institutional Research",
                                "Auxiliary Services and Economic Development",
                                "Benefits and Insurance",
                                "Black Cultural Center",
                                "Bookstore (Pioneer Bookshop)",
                                "Campus Safety",
                                "Cashier",
                                "Catering",
                                "Center for Careers, Life, and Service",
                                "Center for Religion, Spirituality, and Social Justice",
                                "Communications",
                                "Community Enhancement and Engagement",
                                "Conference Operations and Events",
                                "Corporate, Foundation, and Government Relations",
                                "Development and Alumni Relations",
                                "Dining",
                                "Disability Resources",
                                "Diversity and Inclusion",
                                "Environmental Stewardship",
                                "Facilities Management",
                                "Faulconer Gallery",
                                "Financial Aid",
                                "Grinnell Prize",
                                "Human Resources",
                                "Information Technology Services",
                                "Institutional Planning and Budget Planning",
                                "Intercultural Affairs",
                                "International Student Affairs",
                                "Investment Office",
                                "Libraries",
                                "Mail Services",
                                "New Student Orientation",
                                "Off-Campus Study",
                                "Ombuds",
                                "Pioneer Bookshop",
                                "President",
                                "Registrar",
                                "Research Ethics",
                                "Residence Life",
                                "Service and Social Innovation",
                                "Stonewall Resource Center",
                                "Strategic Planning",
                                "Student Affairs",
                                "Student Assistance",
                                "Student Health and Counseling Services",
                                "Treasurer",
                                "Wellness"]
    let SGA: [String] = ["None",
                         "President",
                         "Vice President of Academic Affairs",
                         "Vice President of Student Affairs",
                         "Administrative Coordinator",
                         "Treasurer",
                         "Assistant Treasurer",
                         "All Campus Events Co-Chair",
                         "Services Coordinator",
                         "Diversity and Outreach Coordinator",
                         "Concerts Chair",
                         "Senator",
                         "Class Ambassador",
                         "Presiding Officer",
                         "Technical Advisor"]
    let concentration: [String] = ["None",
                                   "American Studies",
                                   "East Asian Studies",
                                   "Environmental Studies",
                                   "European Studies",
                                   "Global Development Studies",
                                   "Latin American Studies",
                                   "Linguistics",
                                   "Neuroscience",
                                   "Peace and Conflict Studies",
                                   "Physical Education",
                                   "Policy Studies",
                                   "Russian, Central, and Eastern European Studies",
                                   "Statistics",
                                   "Technology Studies"]
    let hiatus: [String] = ["None",
                            "Grinnell in London",
                            "Grinnell in Washington"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var isExpanded: [Bool] = Array(repeating: false, count: 9) //todo
    var params: [String: String?] = ["First name": nil,
                                     "Last name": nil,
                                     "Campus Address or P.O. Box": nil,
                                     "Fac/Staff Dept/Office": nil,
                                     "Student Major": nil,
                                     "Hiatus": nil,
                                     "Computer Username": nil,
                                     "Campus Phone": nil,
                                     "Home Address": nil,
                                     "SGA": nil,
                                     "Concentration": nil,
                                     "Student Class": nil]
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return searchFieldSimple.count
            case 1: return searchFieldDetail.count
            default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            /* indexPath section == 0 */
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath) // no need for check cell type since all TextCell
            if let textCell = cell as? TextTableViewCell {
                textCell.textField.placeholder = searchFieldSimple[indexPath.row]
                return textCell
            }
        } else {
            /* indexPath section == 1 */
            if let cellType = optionToCellType[searchFieldDetail[indexPath.row]] {
                let cell = tableView.dequeueReusableCell(withIdentifier: cellType, for: indexPath)
                switch cellType {
                case "TextCell" :
                    if let textCell = cell as? TextTableViewCell {
                        textCell.textField.placeholder = searchFieldDetail[indexPath.row]
                        return textCell
                    }
                case "NumberCell":
                    if let numberCell = cell as? NumberTableViewCell {
                        numberCell.numberField.placeholder = searchFieldDetail[indexPath.row]
                        return numberCell
                    }
                case "PickerCell":
                    if let pickerCell = cell as? PickerViewTableViewCell {
                        pickerCell.textField?.placeholder = searchFieldDetail[indexPath.row]
                        switch searchFieldDetail[indexPath.row] {
                            case "Fac/Staff Dept/Office": pickerCell.options = department
                            case "Student Major": pickerCell.options = major
                            case "Hiatus": pickerCell.options = hiatus
                            case "Concentration": pickerCell.options = concentration
                            case "SGA": pickerCell.options = SGA
                            default: break
                        }
                        if let param = params[searchFieldDetail[indexPath.row]] {
                            pickerCell.textField.text = param
                        }
                        pickerCell.pickerView.isHidden = !isExpanded[indexPath.row]
                        return pickerCell
                    }
                default: break
                }
            }
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && optionToCellType[searchFieldDetail[indexPath.row]] == "PickerCell" {
            if isExpanded[indexPath.row],
                let pickerCell = tableView.cellForRow(at: indexPath) as? PickerViewTableViewCell,
                let param = pickerCell.textField.text {
                params[searchFieldDetail[indexPath.row]] = param
            }
            isExpanded[indexPath.row] = !isExpanded[indexPath.row]
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0: return "Basic"
            case 1: return "Detail"
            default: return "ERROR"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && isExpanded[indexPath.row] {
            return CGFloat(220.0)
        }
        return CGFloat(61.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        for cell in self.tableView.visibleCells {
            if let textCell = cell as? TextTableViewCell {
                params[textCell.textField.placeholder ?? ""] = textCell.textField.text
            } else if let numberCell = cell as? NumberTableViewCell {
                params[numberCell.numberField.placeholder ?? ""] = numberCell.numberField.text
            } else if let pickerCell = cell as? PickerViewTableViewCell {
                params[pickerCell.textField.placeholder ?? ""] = pickerCell.textField.text
            }
        }
        
        //print(params) // debug
        
        if let listVC = segue.destination as? ListViewController {
            // mock data
            let zixuanGuo: [String: Any] = ["personType": "student",
                                            "firstName": "Zixuan",
                                            "lastName": "Guo",
                                            "userName": "guozixua",
                                            "box": "3603",
                                            "email": "guozixua@grinnell.edu",
                                            "address": "None",
                                            "phone": "(641)-2255-332",
                                            "imgPath": "https://itwebapps.grinnell.edu/PcardImages/moved/98115.jpg",
                                            "homeAddress": "None",
                                            "nickName": "None",
                                            "classYear": "2021",
                                            "major": "Computer Science",
                                            "minor": "Biology"]
            
            let zixuan = Student(dictionary: zixuanGuo)
            listVC.people = [zixuan, zixuan, zixuan, zixuan, zixuan, zixuan, zixuan, zixuan]
        }
    }
}

extension UITextField {
    
    @IBInspectable var doneAccessory: Bool  {
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone {
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
