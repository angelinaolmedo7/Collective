//
//  Category.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/11/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation

class Category: NSObject {
    
    var cat_id: Int?
    var cat_name: String?
    var cat_description: String?
    
    
    //empty constructor
    override init()
    {}
    
    init(cat_id: Int, cat_name: String, cat_description: String) {
        
        self.cat_id = cat_id
        self.cat_name = cat_name
        self.cat_description = cat_description
        
    }
}
