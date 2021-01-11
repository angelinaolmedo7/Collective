//
//  User.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/10/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation

class User: NSObject {

//properties

    var user_id: Int?
    var user_name: String?
//    var uesr_date: Date?
    var user_level: Int?


    //empty constructor
    override init()
    {
        
    }

    //construct with @name, @address, @latitude, and @longitude parameters

    init(user_id: Int, user_name: String, user_level: Int) {
        self.user_id = user_id
        self.user_name = user_name
        self.user_level = user_level
    }
    
    func fetchuser(name: String?) {
        let urlPath = "http://www.collectiveapp.site/fetchuser.php"
        let url: URL = URL(string: urlPath)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let dataString = "&user_name=\(name ?? self.user_name!)"
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
        var jsonResult = NSObject() // change to object?
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSObject
           
        } catch let error as NSError {
            print(error)
        }
       
        var jsonElement = NSDictionary()
        jsonElement = jsonResult as! NSDictionary
           
        let user = User()
           
        //the following insures none of the JsonElement values are nil through optional binding
        if let user_id = jsonElement["user_id"] as? NSString,
            let user_name = jsonElement["user_name"] as? NSString,
//                let uesr_date = jsonElement["user_date"] as? Date,
            let user_level = jsonElement["user_level"] as? NSString
        {
            user.user_id = user_id.integerValue
            user.user_name = user_name as String
//    //            user.user_date = user_date
            user.user_level = user_level.integerValue
               
        }
        
    print(user.user_name)
    }
}
