//
//  Post.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/11/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation

class Post: NSObject {
    
    var post_id: Int?
    var post_content: String?
//    var post_date: Date?
    var post_topic: Int? // topic id number
    var post_by: Int? // user id number
    
    var post_by_name: String = "UNKNOWN USER"
    
    
    //empty constructor
    override init()
    {}
    
    init(post_id: Int, post_content: String, post_topic: Int, post_by: Int) {
        
        self.post_id = post_id
        self.post_content = post_content
        self.post_topic = post_topic
        self.post_by = post_by
        
    }
}

