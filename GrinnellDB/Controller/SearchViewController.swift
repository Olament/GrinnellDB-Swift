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
                                       "Concentration",
                                       "Student Class"] // delete student class temporary
    
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
    let major: [String] = ["",
                           "Anthropology",
                           "Art History",
                           "Biological Chemistry",
                           "Biology",
                           "Certificate",
                           "Chemistry",
                           "Chinese",
                           "Classics",
                           "Computer Science",
                           "Economics",
                           "English",
                           "Exchange Student",
                           "French",
                           "Gender, Womens, & Sexuality St",
                           "General Science-Biology",
                           "General Science-Chemistry",
                           "General Science-Computer Sci",
                           "General Science-Math",
                           "General Science-Physics",
                           "General Science-Psychology",
                           "German",
                           "German Studies",
                           "History",
                           "Independent",
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
                           "Theatre and Dance",
                           "Undeclared"]
    
    let department: [String] = ["",
                                "Accounting",
                                "Admission",
                                "Analytics & Inst. Research",
                                "Anthropology",
                                "Art and Art History",
                                "Athletics",
                                "Aux Services & Economic Dev",
                                "Biology",
                                "Bookstore",
                                "Campus Safety",
                                "Careers, Life, and Service",
                                "Center International Studies",
                                "Center Teach, Learn & Assess",
                                "Chemistry",
                                "Chinese & Japanese",
                                "Classics (Greek & Latin)",
                                "College Contacts",
                                "Comm. Enhancement & Engagement",
                                "Communications",
                                "Computer Science",
                                "Conference Operations & Events",
                                "Corp. Found. & Gov't Rel.",
                                "CRSSJ",
                                "Dean of the College",
                                "Development & Alumni Relations",
                                "Dining Services",
                                "Economics",
                                "Education",
                                "English",
                                "Facilities Management",
                                "Financial Aid",
                                "French and Arabic",
                                "Gender, Women's and Sexuality Studies",
                                "German",
                                "Grinnell College Museum of Art",
                                "Grinnell-In-London",
                                "Grinnell-In-Washington",
                                "History",
                                "Human Resources",
                                "Information Technology Service",
                                "Inst. for Global Engagement",
                                "Library",
                                "Mail Services",
                                "Math Lab",
                                "Mathematics & Statistics",
                                "Midwest Conference",
                                "Music",
                                "Off-Campus Study",
                                "Office of Investments",
                                "Office of the Ombuds",
                                "Office of the Treasurer",
                                "Peace and Conflict Studies Pro",
                                "Philosophy",
                                "Physical Education",
                                "Physics",
                                "Political Science",
                                "President",
                                "Psychology",
                                "Reading Lab",
                                "Registrar",
                                "Religious Studies",
                                "Russian",
                                "Science Dept",
                                "Sociology",
                                "Spanish",
                                "Student Affairs",
                                "Student Health & Counseling",
                                "Student Health & Wellness",
                                "Theatre and Dance",
                                "Wilson Program",
                                "Writing Lab"]
    
    let SGA: [String] = ["",
                         "2020 Class Ambassador",
                         "2021 Class Ambassador",
                         "2022 Class Ambassador ",
                         "2023 Class Ambassador",
                         "Administrative Coordinator",
                         "All Campus Events Coordinator",
                         "Assistant Treasurer",
                         "CaNaDa Senator",
                         "Clangrala Senator",
                         "Concerts Chair",
                         "Diversity and Outreach Coordinator",
                         "Election Board Chair",
                         "Green Fund Chair",
                         "Jamaland Senator",
                         "Judiciary Committee Chair",
                         "LaKerRoJe Senator",
                         "Loosehead Senator",
                         "OCCO Senator",
                         "OCNCO Senator",
                         "President",
                         "President ELECT",
                         "Student Services Coordinator",
                         "Technology Advisor",
                         "Treasurer",
                         "VP for Academic Affairs",
                         "VP for Academic Affairs ELECT",
                         "VP for Student Affairs",
                         "VP for Student Affairs ELECT"]
    
    let concentration: [String] = ["",
                                   "American Studies",
                                   "American Studies/Policy Studies",
                                   "American Studies/Russian & East European Stds",
                                   "East Asian Studies",
                                   "Environmental Studies",
                                   "European Studies Concentration",
                                   "Global Development Studies",
                                   "Global Development Studies/Peace and Conflict Studies",
                                   "Latin American Studies",
                                   "Linguistics",
                                   "Linguistics/Statistics",
                                   "Neuroscience",
                                   "Neuroscience/Policy Studies",
                                   "Peace and Conflict Studies",
                                   "Policy Studies",
                                   "Russian & East European Stds",
                                   "Statistics",
                                   "Statistics/Neuroscience",
                                   "Technology Studies"]
    
    let hiatusValue: [String:String] = ["": "",
                                 "Off Campus Study": "ACLV",
                                 "Engineering":"ENGR",
                                 "Grinnell in London":"GIL",
                                 "Grinnell in Washington":"GIW"]
    
    let hiatusText: [String:String] = ["":"",
                                       "ACLV":"Off Campus Study",
                                       "ENGR":"Engineering",
                                       "GIL":"Grinnell in London",
                                       "GIW":"Grinnell in Washington"]
    
    let classyear: [String] = ["",
                               "2019",
                               "2020",
                               "2021",
                               "2022",
                               "2023"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let cookie = defaults.string(forKey: "cookie") {
            checkCookieValidity(cookieValue: cookie)
        } else {
            createAlert(title: "Login Needed", message: "You need to login with your Grinnell College account in order to use GrinnellDB")
        }
    }
    
    var isExpanded: [Bool] = Array(repeating: false, count: 10) //todo
    
    var params: [String: String] = ["First name": "",
                                     "Last name": "",
                                     "Campus Address or P.O. Box": "",
                                     "Fac/Staff Dept/Office": "",
                                     "Student Major": "",
                                     "Hiatus": "",
                                     "Computer Username": "",
                                     "Campus Phone": "",
                                     "Home Address": "",
                                     "SGA": "",
                                     "Concentration": "",
                                     "Student Class": ""]
    
    func snapshotParams() {
        for cell in self.tableView.visibleCells {
            if let textCell = cell as? TextTableViewCell {
                params[textCell.textField.placeholder ?? ""] = textCell.textField.text
            } else if let numberCell = cell as? NumberTableViewCell {
                params[numberCell.numberField.placeholder ?? ""] = numberCell.numberField.text
            } else if let pickerCell = cell as? PickerViewTableViewCell {
                if pickerCell.textField.placeholder == "Hiatus" {
                    params["Hiatus"] = hiatusValue[pickerCell.textField.text ?? ""]
                } else {
                    params[pickerCell.textField.placeholder ?? ""] = pickerCell.textField.text
                }
            }
        }
    }
    
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
                textCell.textField.text =
                params[searchFieldDetail[indexPath.row]] ?? ""
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
                        textCell.textField.text =
                            params[searchFieldDetail[indexPath.row]] ?? ""
                        return textCell
                    }
                case "NumberCell":
                    if let numberCell = cell as? NumberTableViewCell {
                        numberCell.numberField.placeholder = searchFieldDetail[indexPath.row]
                        numberCell.numberField.text =
                        params[searchFieldDetail[indexPath.row]] ?? ""
                        return numberCell
                    }
                case "PickerCell":
                    if let pickerCell = cell as? PickerViewTableViewCell {
                        pickerCell.textField?.placeholder = searchFieldDetail[indexPath.row]
                        switch searchFieldDetail[indexPath.row] {
                            case "Fac/Staff Dept/Office": pickerCell.options = department
                            case "Student Major": pickerCell.options = major
                            case "Hiatus": pickerCell.options = Array(hiatusValue.keys)
                            case "Concentration": pickerCell.options = concentration
                            case "SGA": pickerCell.options = SGA
                            case "Student Class": pickerCell.options = classyear
                            default: break
                        }
                        if var param = params[searchFieldDetail[indexPath.row]] {
                            if searchFieldDetail[indexPath.row] == "Hiatus" {
                                param = hiatusText[param]!
                            }
                            pickerCell.textField.text = param
                            let currentSelectedRow = pickerCell.options.firstIndex(of: param ) ?? 0
                            pickerCell.pickerView.selectRow(currentSelectedRow, inComponent: 0, animated: false)
                        } else {
                            pickerCell.textField.text = ""
                            pickerCell.pickerView.selectRow(0, inComponent: 0, animated: false)
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
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let textCell = cell as? TextTableViewCell {
            params[textCell.textField.placeholder ?? ""] = textCell.textField.text
        } else if let numberCell = cell as? NumberTableViewCell {
            params[numberCell.numberField.placeholder ?? ""] = numberCell.numberField.text
        } else if let pickerCell = cell as? PickerViewTableViewCell {
            if pickerCell.textField.placeholder == "Hiatus" {
                params["Hiatus"] = hiatusValue[pickerCell.textField.text ?? ""]
            } else {
                params[pickerCell.textField.placeholder ?? ""] = pickerCell.textField.text
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let textCell = cell as? TextTableViewCell {
            textCell.textField.text = params[textCell.textField.placeholder ?? ""]
        } else if let numberCell = cell as? NumberTableViewCell {
            numberCell.numberField.text = params[numberCell.numberField.placeholder ?? ""]
        } else if let pickerCell = cell as? PickerViewTableViewCell {
            if pickerCell.textField.placeholder == "Hiatus" {
                pickerCell.textField.text = hiatusText[params["Hiatus"]!]
            } else {
                pickerCell.textField.text = params[pickerCell.textField.placeholder ?? ""]
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        snapshotParams()
        if indexPath.section == 1 && optionToCellType[searchFieldDetail[indexPath.row]] == "PickerCell" {
            if isExpanded[indexPath.row],
                let pickerCell = tableView.cellForRow(at: indexPath) as? PickerViewTableViewCell,
                let param = pickerCell.textField.text {
                if pickerCell.textField.placeholder == "Hiatus" {
                    params[searchFieldDetail[indexPath.row]] = hiatusValue[param]
                } else {
                    params[searchFieldDetail[indexPath.row]] = param
                }
            }
            isExpanded[indexPath.row] = !isExpanded[indexPath.row]
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
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
    
    // MARK: - Login
    
    func checkCookieValidity(cookieValue cookie: String) {
        /* sketchy way of checking validity of cookie */
        var urlString = "https://appdev.grinnell.edu/api/db/v1/fetch?lastName=Zixuan&token="
        urlString += cookie
                
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, err) in
            guard let data = data else {
                return
            }
                
            do {
                let response = try JSONDecoder().decode(QueryResult.self, from: data)
                if !response.errMessage.isEmpty {
                    DispatchQueue.main.async {
                        self.createAlert(title: "Invalid Cookie", message: "Please re-login your Grinnell College account")
                    }
                }
            } catch let jsonerr {
                print(jsonerr)
            }
        }.resume()
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "login", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        snapshotParams()
        
        //print(params) // debug
        
        if let listVC = segue.destination as? ListViewController {
            listVC.params = self.params
        }
    }
    
    // MARK: - Reset
    @IBAction func resetButtonTapped(_ sender: Any) {
        print("reset")
        for cell in self.tableView.visibleCells {
            if let textCell = cell as? TextTableViewCell {
                textCell.textField.text = ""
            } else if let numberCell = cell as? NumberTableViewCell {
                numberCell.numberField.text = ""
            } else if let pickerCell = cell as? PickerViewTableViewCell {
                pickerCell.textField.text = ""
                pickerCell.pickerView.selectRow(0, inComponent: 0, animated: false)
                pickerCell.pickerView.isHidden = true
            }
        }
        isExpanded = Array(repeating: false, count: 10)
        for (key, _) in params {
            params[key] = ""
        }
        tableView.reloadData()
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


