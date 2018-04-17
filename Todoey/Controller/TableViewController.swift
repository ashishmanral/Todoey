//
//  ViewController.swift
//  Todoey
//
//  Created by Manral, Ashish on 4/16/18.
//  Copyright © 2018 Manral, Ashish. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var items = [Item(itemName : "Kela"), Item(itemName : "Chawal"), Item(itemName : "Pulao")]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let cachedItems = defaults.array(forKey: "items") as? [Item] {
            items = cachedItems
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].itemName
        cell.accessoryType = items[indexPath.row].checked ? .checkmark : .none
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].checked = items[indexPath.row].checked == false ? true : false
        tableView.cellForRow(at: indexPath)?.accessoryType = items[indexPath.row].checked ? .checkmark : .none
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var addTf : UITextField?
        
        let alertController = UIAlertController(title: "Add an item", message: "What do you have in mind?", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField) in
            addTf = textField
            textField.placeholder = "Enter item here"
        }
        alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            if let textField = addTf {
                if let text = textField.text {
                    if !text.isEmpty {
                        self.items.append(Item(itemName: text))
                        self.defaults.set(self.items, forKey: "items")
                        self.tableView.reloadData()
                    }
                }
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}

