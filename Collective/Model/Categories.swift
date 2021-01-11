//
//  Categories.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/11/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation

class Categories: NSObject, URLSessionDataDelegate {
    
    weak var delegate: NetworkProtocol!
    let urlPath = "http://www.collectiveapp.site/getcategories.php"
 
    func downloadItems() {
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
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
        let cats = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let cat = Category()
            
            //the following ensures none of the JsonElement values are nil through optional binding
            if let cat_id = jsonElement["cat_id"] as? NSString,
                let cat_name = jsonElement["cat_name"] as? String,
                let cat_description = jsonElement["cat_description"] as? String
            {
                cat.cat_id = cat_id.integerValue
                cat.cat_name = cat_name
                cat.cat_description = cat_description
            }
            cats.add(cat)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate.itemsDownloaded(items: cats)
        })
    }
}

