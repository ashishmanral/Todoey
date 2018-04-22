//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Manral, Ashish on 4/20/18.
//  Copyright © 2018 Manral, Ashish. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask))
        categories = TodoeyHelper.loadCategories()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TableViewController
        destinationVC.category = categories[(tableView.indexPathForSelectedRow?.row)!]
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var addTf : UITextField?
        
        let alertController = UIAlertController(title: "Add a category", message: "What do you have in mind?", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField) in
            addTf = textField
            textField.placeholder = "Enter category here"
        }
        alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            if let textField = addTf {
                if let text = textField.text {
                    if !text.isEmpty {
                        let newCategory = Category(context: self.context)
                        newCategory.name = text
                        self.categories.append(newCategory)
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
