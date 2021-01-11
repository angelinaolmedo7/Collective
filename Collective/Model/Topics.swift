//
//  Topics.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/11/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation

class Topics: NSObject, URLSessionDataDelegate {
    
    weak var delegate: NetworkProtocol!
    let urlPath = "http://www.collectiveapp.site/gettopics.php"
 
    func downloadItems(topic_cat: Int?) {
        let url: URL = URL(string: urlPath)!
        var request = URLRequest(url: url)
         request.httpMethod = "POST"
         
         let dataString = "&topic_cat=\(topic_cat ?? 1)"
         // convert the post string to utf8 format
         let dataD = dataString.data(using: .utf8) // convert to utf8 string
         
         let task = URLSession.shared.uploadTask(with: request, from: dataD)
         {
             data, response, error in
             if error != nil {
                 print("Failed to download data")
             } else {
                 print("Data downloaded")
                 print(data as Any)
                 self.parseJSON(data!)
             }
            }
            task.resume()
        }
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        } catch let error as NSError {
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let topics = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let topic = Topic()
            
            //the following ensures none of the JsonElement values are nil through optional binding
            if let topic_id = jsonElement["topic_id"] as? NSString,
                let topic_subject = jsonElement["topic_subject"] as? String,
                let topic_cat = jsonElement["topic_cat"] as? NSString,
                let topic_by = jsonElement["topic_by"] as? NSString
            {
                topic.topic_id = topic_id.integerValue
                topic.topic_subject = topic_subject
                topic.topic_cat = topic_cat.integerValue
                topic.topic_by = topic_by.integerValue
            }
            topics.add(topic)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate.itemsDownloaded(items: topics)
        })
    }
}

