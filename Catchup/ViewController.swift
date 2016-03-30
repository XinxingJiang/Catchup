//
//  ViewController.swift
//  Catchup
//
//  Created by Xinxing Jiang on 3/30/16.
//  Copyright © 2016 PalmTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var alertController: UIAlertController!

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
            textField.placeholder = "Name"
        }
        alertController.addTextFieldWithConfigurationHandler { textField in
            textField.placeholder = "MM/DD/YYYY"
            textField.keyboardType = .NumberPad
        }
        alertController.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.Default, handler: { _ in
            print("submit")
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
}

