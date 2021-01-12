//
//  ItemsViewController.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/11/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation
import UIKit

class ItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NetworkProtocol {
    
    var user: User = User()
    var selectedCategory : Category = Category()
    var feedItems: NSArray = NSArray()

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var catLabel: UILabel!
    @IBOutlet weak var leaderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        catLabel.text = selectedCategory.cat_name ?? "NAME"
        
        self.setLeader()
        
        let items = Items()
        items.delegate = self
        items.downloadItems(item_cat: selectedCategory.cat_id ?? 3)
    }
    
    func setLeader() {
        var leader_id: Int
        
        let urlPath = "http://www.collectiveapp.site/getleader.php"
        let url: URL = URL(string: urlPath)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let dataString = "&instance_cat=\(selectedCategory.cat_id!)"
        // convert the post string to utf8 format
        let dataD = dataString.data(using: .utf8) // convert to utf8 string
        
        let task = URLSession.shared.uploadTask(with: request, from: dataD)
        {
            data, response, error in
            if error != nil {
                print("Failed to download data")
            } else {
                print("Data downloaded")
                var jsonResult = NSObject() // change to object?
                do{
                    jsonResult = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.allowFragments) as! NSObject
                   
                } catch let error as NSError {
                    print(error)
                }
               
                var jsonElement = NSDictionary()
                jsonElement = jsonResult as! NSDictionary
                   
                //the following ensures none of the JsonElement values are nil through optional binding
                if let user_id = jsonElement["instance_user"] as? NSString
                {
                    DispatchQueue.main.async {
                        self.leaderLabel.text = "Current category leader: #\(user_id as String)"
                    }
                }
            }
           }
           task.resume()
        
    }

    func itemsDownloaded(items: NSArray) {
            feedItems = items
            self.listTableView.reloadData()
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Retrieve cell
        let cellIdentifier: String = "ItemCell"
        let myCell: ItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as! ItemTableViewCell
        // Get the item to be shown
        let item: Item = feedItems[indexPath.row] as! Item
        // Get references to labels of cell
        myCell.setDetails(user: user, item: item)
            
        return myCell
    }
}

    



