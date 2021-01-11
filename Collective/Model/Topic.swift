//
//  Topic.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/11/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation

class Topic: NSObject {
    
    var topic_id: Int?
    var topic_subject: String?
//    var topic_date: Date?
    var topic_cat: Int? // cat id number
    var topic_by: Int? // user id number
    
    
    //empty constructor
    override init()
    {}
    
    init(topic_id: Int, topic_subject: String, topic_cat: Int, topic_by: Int) {
        
        self.topic_id = topic_id
        self.topic_subject = topic_subject
        self.topic_cat = topic_cat
        self.topic_by = topic_by
        
    }
}
