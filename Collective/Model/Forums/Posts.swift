//
//  Posts.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/11/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation

class Posts: NSObject, URLSessionDataDelegate {
    
    weak var delegate: NetworkProtocol!
    let urlPath = "http://www.collectiveapp.site/getposts.php"
 
    func downloadItems(post_topic: Int?) {
        let url: URL = URL(string: urlPath)!
        var request = URLRequest(url: url)
         request.httpMethod = "POST"
         
         let dataString = "&post_topic=\(post_topic ?? 1)"
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
        let posts = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let post = Post()
            
            //the following ensures none of the JsonElement values are nil through optional binding
            if let post_id = jsonElement["post_id"] as? NSString,
                let post_content = jsonElement["post_content"] as? String,
                let post_topic = jsonElement["post_topic"] as? NSString,
                let post_by = jsonElement["post_by"] as? NSString
            {
                post.post_id = post_id.integerValue
                post.post_content = post_content
                post.post_topic = post_topic.integerValue
                post.post_by = post_by.integerValue
            }
            posts.add(post)
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate.itemsDownloaded(items: posts)
        })
    }
}


