//
//  Item.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/11/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation

class Item: NSObject {
    
    var item_id: Int?
    var item_name: String?
    var item_cat: Int? // cat id number
    
    
    //empty constructor
    override init()
    {}
    
    init(item_id: Int, item_name: String, topic_cat: Int, item_cat: Int) {
        
        self.item_id = item_id
        self.item_name = item_name
        self.item_cat = item_cat
        
    }
}

