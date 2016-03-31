//
//  ViewController.swift
//  Catchup
//
//  Created by Xinxing Jiang on 3/30/16.
//  Copyright © 2016 PalmTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var alertController: UIAlertController!
    var submitAction: UIAlertAction!
    var nameTextField: UITextField!
    var dateTextField: UITextField!

    var items: [ItemModel]!
    
    // MARK: - VC life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: - Click sort by name button
    
    @IBAction func sortByName() {
        alertController = UIAlertController()
        alertController.addAction(UIAlertAction(title: "A to Z", style: UIAlertActionStyle.Default, handler: { _ in
            print("A to Z")
        }))
        alertController.addAction(UIAlertAction(title: "Z to A", style: UIAlertActionStyle.Default, handler: { _ in
            print("Z to A")
        }))
        presentViewController(alertController, animated: true, completion: nil)
    }

    // MARK: - Click sort by date button
    
    @IBAction func sortByDate() {
        alertController = UIAlertController()
        alertController.addAction(UIAlertAction(title: "Most recent", style: UIAlertActionStyle.Default, handler: { _ in
            print("most recent")
        }))
        alertController.addAction(UIAlertAction(title: "Least recent", style: UIAlertActionStyle.Default, handler: { _ in
            print("least recent")
        }))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Click add button
    
    @IBAction func add() {
        alertController = UIAlertController(title: "New item", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addTextFieldWithConfigurationHandler { textField in
            self.nameTextField = textField
            textField.placeholder = "Name"
            textField.delegate = self
        }
        
        alertController.addTextFieldWithConfigurationHandler { textField in
            self.dateTextField = textField
            textField.placeholder = "MM/DD/YYYY"
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
    
    // MARK: - Alert controller delegate
    
    // MARK: - Text field delegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let stringAfterEdit = NSString(string: textField.text!).stringByReplacingCharactersInRange(range, withString: string)
        if textField == nameTextField {
            submitAction.enabled = !stringAfterEdit.isEmpty && isDateValid(date: dateTextField.text!)
        }
        if textField == dateTextField {
            submitAction.enabled = !nameTextField.text!.isEmpty && isDateValid(date: stringAfterEdit)
            
            // lazily insert or delete seperator /
            let stringLengthBeforeEdit = textField.text!.characters.count
            let stringLengthAfterEdit = stringAfterEdit.characters.count
            
            // insert seperator
            if (stringLengthAfterEdit == 3 || stringLengthAfterEdit == 6) && stringLengthAfterEdit > stringLengthBeforeEdit {
                textField.text = textField.text! + "/" + string
                return false
            }
            
            // delete seperator
            if (stringLengthAfterEdit == 2 || stringLengthAfterEdit == 5) && stringLengthAfterEdit < stringLengthBeforeEdit {
                textField.text = stringAfterEdit.substringToIndex(stringAfterEdit.endIndex.advancedBy(-1))
                return false
            }
            
            // length upper limit
            if stringLengthAfterEdit > 10 {
                return false
            }
        }
        return true
    }
    
    func submit() {
        
    }
    
    func isDateValid(date date: String) -> Bool {
        // TO DO
        return !date.isEmpty
    }
}

