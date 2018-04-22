//
//  ViewController.swift
//  Todoey
//
//  Created by Manral, Ashish on 4/16/18.
//  Copyright © 2018 Manral, Ashish. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var items = [Item]()
    var category : Category? {
        didSet {
            items = TodoeyHelper.loadItems(categoryName: (category?.name)!)
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask))
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
        TodoeyHelper.saveData()
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
                        let newItem = Item(context: self.context)
                        newItem.itemName = text
                        newItem.checked = false
                        newItem.category = self.category
                        self.items.append(newItem)
                        TodoeyHelper.saveData()
                        self.tableView.reloadData()
                    }
                }
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}

extension TableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        var predicate : NSPredicate?
        if searchBar.text?.count != 0 {
            predicate = NSPredicate(format: "itemName CONTAINS[cd] %@", searchText)
            request.sortDescriptors = [NSSortDescriptor(key: "itemName", ascending: true)]
        }
        items = TodoeyHelper.loadItems(with: request, additionalPredicate: predicate, categoryName: (category?.name)!)
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        items = TodoeyHelper.loadItems(categoryName: (category?.name)!)
        tableView.reloadData()
    }

}


