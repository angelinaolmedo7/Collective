//
//  Network.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/9/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation

protocol NetworkProtocol: class {
    func itemsDownloaded(items: NSArray)
}


class Network: NSObject, URLSessionDataDelegate {
    
    weak var delegate: NetworkProtocol!
    
    let urlPath = "http://www.collectiveapp.site/signin.php"
 
    func downloadItems(urlPath: String) {
        
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
        let tests = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let test = TestTableModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let name1 = jsonElement["Name1"] as? String,
                let name2 = jsonElement["Name2"] as? String,
                let name3 = jsonElement["Name3"] as? String,
                let name4 = jsonElement["Name4"] as? String
            {
                
                test.name1 = name1
                test.name2 = name2
                test.name3 = name3
                test.name4 = name4
                
            }
            
            tests.add(test)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: tests)
            
        })
    }
}
