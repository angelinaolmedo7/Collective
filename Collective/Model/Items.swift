//
//  Items.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/11/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation

class Items: NSObject, URLSessionDataDelegate {
    
    weak var delegate: NetworkProtocol!
    let urlPath = "http://www.collectiveapp.site/getitems.php"
 
    func downloadItems(item_cat: Int?) {
        let url: URL = URL(string: urlPath)!
        var request = URLRequest(url: url)
         request.httpMethod = "POST"
         
         let dataString = "&item_cat=\(item_cat ?? 1)"
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
        let items = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let item = Item()
            
            //the following ensures none of the JsonElement values are nil through optional binding
            if let item_id = jsonElement["item_id"] as? NSString,
                let item_name = jsonElement["item_name"] as? String,
                let item_cat = jsonElement["item_cat"] as? NSString
            {
                item.item_id = item_id.integerValue
                item.item_name = item_name
                item.item_cat = item_cat.integerValue
            }
            items.add(item)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate.itemsDownloaded(items: items)
        })
    }
}

