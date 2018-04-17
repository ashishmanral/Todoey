//
//  Item.swift
//  Todoey
//
//  Created by Manral, Ashish on 4/17/18.
//  Copyright © 2018 Manral, Ashish. All rights reserved.
//

import Foundation

class Item {
    
    let itemName : String?
    var checked = false
    
    init(itemName : String) {
        self.itemName = itemName
    }
    
}
