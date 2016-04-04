//
//  ViewController.swift
//  Catchup
//
//  Created by Xinxing Jiang on 3/30/16.
//  Copyright © 2016 PalmTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Fields
    
    var alertController: UIAlertController!
    var submitAction: UIAlertAction!
    var nameTextField: UITextField!
    var dateTextField: UITextField!

    // MARK: - Model
    
    var items: [[String: String]]! {
        didSet {
            tableView.reloadData()
            DefaultsUtil.setUserDefaults(key: "items", value: items)
        }
    }
    
    // MARK: - VC life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = DefaultsUtil.getUserDefaults(key: "items") as? [[String: String]] ?? [[String: String]]()

        // setup table view
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - Sort by name button action
    
    @IBAction func sortByName() {
        alertController = UIAlertController()
        alertController.addAction(UIAlertAction(title: "A to Z", style: UIAlertActionStyle.Default, handler: { _ in
            self.items.sortInPlace{$0["name"] < $1["name"]}
        }))
        alertController.addAction(UIAlertAction(title: "Z to A", style: UIAlertActionStyle.Default, handler: { _ in
            self.items.sortInPlace{$0["name"] > $1["name"]}
        }))
        presentViewController(alertController, animated: true, completion: nil)
    }

    // MARK: - Sort by date button action
    
    @IBAction func sortByDate() {
        alertController = UIAlertController()
        alertController.addAction(UIAlertAction(title: "Most recent", style: UIAlertActionStyle.Default, handler: { _ in
            self.items.sortInPlace{$0["date"] > $1["date"]}
            print(self.items)
        }))
        alertController.addAction(UIAlertAction(title: "Least recent", style: UIAlertActionStyle.Default, handler: { _ in
            self.items.sortInPlace{$0["date"] < $1["date"]}
            print(self.items)
        }))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Add button action
    
    @IBAction func add() {
        alertController = UIAlertController(title: "New item", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addTextFieldWithConfigurationHandler { textField in
            self.nameTextField = textField
            textField.placeholder = "Name"
            textField.delegate = self
        }
        
        alertController.addTextFieldWithConfigurationHandler { textField in
            self.dateTextField = textField
            textField.placeholder = "YYYY/MM/DD"
            textField.keyboardType = .NumberPad
            textField.delegate = self
        }
        
        submitAction = UIAlertAction(title: "Submit", style: .Default) { (_) in
            self.submit()
        }
        submitAction.enabled = false
        alertController.addAction(submitAction)

        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Submit button action
    
    private func submit() {
        let name = nameTextField.text!
        let date = dateTextField.text!
        // if name is existed, update
        for i in 0..<items.count {
            if items[i]["name"] == name {
                items[i]["date"] = date
                return
            }
        }
        // otherwise, insert
        items.append(["name": name, "date": date])
    }
    
    // MARK: - Text field delegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let stringAfterEdit = NSString(string: textField.text!).stringByReplacingCharactersInRange(range, withString: string)
        if textField == nameTextField {
            submitAction.enabled = !stringAfterEdit.isEmpty && isDateValid(date: dateTextField.text!)
        }
        if textField == dateTextField {
            let stringLengthBeforeEdit = textField.text!.characters.count
            let stringLengthAfterEdit = stringAfterEdit.characters.count

            // length upper limit
            if stringLengthAfterEdit > 10 {
                return false
            }

            submitAction.enabled = !nameTextField.text!.isEmpty && isDateValid(date: stringAfterEdit)
            
            // lazily insert or delete seperator /
            
            // insert seperator
            if (stringLengthAfterEdit == 5 || stringLengthAfterEdit == 8) && stringLengthAfterEdit > stringLengthBeforeEdit {
                textField.text = textField.text! + "/" + string
                return false
            }
            
            // delete seperator
            if (stringLengthAfterEdit == 4 || stringLengthAfterEdit == 7) && stringLengthAfterEdit < stringLengthBeforeEdit {
                textField.text = stringAfterEdit.substringToIndex(stringAfterEdit.endIndex.advancedBy(-1))
                return false
            }
        }
        return true
    }
    
    // MARK: - Table view data source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        cell.item = items[indexPath.row]
        return cell
    }
    
    // MARK: - Date checker
    
    private func isDateValid(date date: String) -> Bool {
        let components = date.componentsSeparatedByString("/")
        if components.count != 3 {
            return false
        }
        let year = Int(components[0])
        let month = Int(components[1])
        let day = Int(components[2])
        if month == nil || day == nil || year == nil {
            return false
        }
        return DateUtil.isDateValid(year: year!, month: month!, day: day!)
    }
}

