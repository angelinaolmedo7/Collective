//
//  TestTableModel.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/8/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation

class TestTableModel: NSObject {
    
    //properties
    
    var name1: String?
    var name2: String?
    var name3: String?
    var name4: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(name1: String, name2: String, name3: String, name4: String) {
        
        self.name1 = name1
        self.name2 = name2
        self.name3 = name3
        self.name4 = name4
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "Name1: \(name1), Name2: \(name2), Name3: \(name3), Name4: \(name4)"
        
    }
    
    
}
