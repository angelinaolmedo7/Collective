//
//  ItemTableViewCell.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/11/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemCheck: UIButton!
    
    var instance_id: Int?
    
    var item: Item = Item()
    var user: User = User()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func checkPressed(_ sender: Any) {
        if self.instance_id == 0 {  // not checked
            self.checkItem()
        }
        else {
            self.uncheckItem()
        }
    }
    
    func setDetails(user: User?, item: Item?) {
        guard let user = user else {
            print ("EMPTY USER RECEIVED")
            return
        }
        guard let item = item else {
            print ("EMPTY ITEM RECEIVED")
            return
        }
        self.user = user
        self.item = item
        self.itemLabel.text = item.item_name ?? "ITEM NOT FOUND"
        self.getInstance()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCheckImage() {
        if self.instance_id ?? 0 != 0 {  // exists
            self.itemCheck.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
        else {
            self.itemCheck.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
    }
    
    func uncheckItem() {
        // delete instance in db
        let urlPath = "http://www.collectiveapp.site/deleteinstance.php"
        
        var request = URLRequest(url: URL(string: urlPath)!)
        request.httpMethod = "POST"
        
        var dataString = ""
        
        // the POST string has entries separated by &
        dataString = dataString + "&instance_id=\(self.instance_id!)"
        
        // convert the post string to utf8 format
        let dataD = dataString.data(using: .utf8) // convert to utf8 string
        do
        {
            // the upload task, uploadJob, is defined here
            let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD)  // h8 the name uploadjob change later
            {
                data, response, error in
                if error != nil {
                    print("Failed to upload data")
                } else {
                    print("Data uploaded")
                    
                    DispatchQueue.main.async {
                        self.getInstance()
                    }
                }
            }
            uploadJob.resume()
        }

    }
    
    func getInstance() {
        let urlPath = "http://www.collectiveapp.site/checkinstances.php"
        
        var request = URLRequest(url: URL(string: urlPath)!)
        request.httpMethod = "POST"
        
        var dataString = ""
        
        // the POST string has entries separated by &
        dataString = dataString + "&instance_item=\(item.item_id!)"
        dataString = dataString + "&instance_user=\(user.user_id!)"
        
        // convert the post string to utf8 format
        let dataD = dataString.data(using: .utf8) // convert to utf8 string
        do
        {
            // the upload task, uploadJob, is defined here
            let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD)  // h8 the name uploadjob change later
            {
                data, response, error in
                if error != nil {
                    print("Failed to download data")
                } else {
                    print("Data downloaded")
                    print(data as Any)
                    var jsonResult = NSObject() // change to object?
                    do{
                        jsonResult = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.allowFragments) as! NSObject
                       
                    } catch let error as NSError {
                        print(error)
                    }
                    
                    if let jsonElement = jsonResult as? NSDictionary {
                        if let instance_id = jsonElement["instance_id"] as? NSString
                        {
                            self.instance_id = instance_id.integerValue
                        }
                    }
                    else {
                        self.instance_id = 0
                    }
                    DispatchQueue.main.async {
                        self.updateCheckImage()
                    }
                }
            }
            uploadJob.resume()
        }
    }
    
    func checkItem() {
        // upload new instance
        
        let urlPath = "http://www.collectiveapp.site/createinstance.php"
        
        var request = URLRequest(url: URL(string: urlPath)!)
        request.httpMethod = "POST"
        
        var dataString = ""
        
        // the POST string has entries separated by &
        dataString = dataString + "&instance_item=\(item.item_id!)"
        dataString = dataString + "&instance_user=\(user.user_id!)"
        dataString = dataString + "&instance_cat=\(item.item_cat!)"
        
        // convert the post string to utf8 format
        let dataD = dataString.data(using: .utf8) // convert to utf8 string
        do
        {
            // the upload task, uploadJob, is defined here
            let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD)  // h8 the name uploadjob change later
            {
                data, response, error in
                if error != nil {
                    print("Failed to upload data")
                } else {
                    print("Data uploaded")
                    
                    DispatchQueue.main.async {
                        self.getInstance()
                    }
                }
            }
            uploadJob.resume()
        }
    }
    
}
