//
//  TodoeyHelper.swift
//  Todoey
//
//  Created by Manral, Ashish on 4/20/18.
//  Copyright © 2018 Manral, Ashish. All rights reserved.
//

import UIKit
import CoreData

class TodoeyHelper {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func saveData() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    static func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), additionalPredicate : NSPredicate? = nil, categoryName : String) -> [Item] {
        
        let categoryPredicate = NSPredicate(format: "category.name MATCHES %@", categoryName)
        if let unwrappedAdditionalPredicate = additionalPredicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [unwrappedAdditionalPredicate, categoryPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        return [Item]()
    }
    
    static func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()) -> [Category] {
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        return [Category]()
    }
    
}
