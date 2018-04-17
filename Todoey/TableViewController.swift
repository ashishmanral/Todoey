//
//  ViewController.swift
//  Todoey
//
//  Created by Manral, Ashish on 4/16/18.
//  Copyright © 2018 Manral, Ashish. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var items = ["Kela", "Chawal", "Pulao"]
    var addTf : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentAccessoryType = tableView.cellForRow(at: indexPath)?.accessoryType
        tableView.cellForRow(at: indexPath)?.accessoryType = currentAccessoryType == .checkmark ? .none : .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add an item", message: "What do you have in mind?", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField) in
            self.addTf = textField
            textField.placeholder = "Enter item here"
        }
        alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            if let textField = self.addTf {
                if let text = textField.text {
                    if !text.isEmpty {
                        self.items.append(text)
                        self.tableView.reloadData()
                    }
                }
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}

