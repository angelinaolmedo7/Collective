//
//  TopicsViewController.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/11/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation
import UIKit

class TopicsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NetworkProtocol {
    
    var user: User = User()
    var selectedCategory : Category = Category()
    var feedItems: NSArray = NSArray()
    var selectedItem : Topic = Topic()

    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let topics = Topics()
        topics.delegate = self
        topics.downloadItems(topic_cat: selectedCategory.cat_id ?? 3)
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
        let cellIdentifier: String = "TopicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the category to be shown
        let item: Topic = feedItems[indexPath.row] as! Topic
        // Get references to labels of cell
        myCell.textLabel!.text = item.topic_subject
            
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Set selected location to var
        selectedItem = feedItems[indexPath.row] as! Topic
        // Manually call segue to detail view controller
        self.performSegue(withIdentifier: "postSegue", sender: "TopicCell")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as? String) == "TopicCell" {
            // Get reference to the destination view controller
            let detailVC  = segue.destination as! PostsViewController
            // Set the property to the selected location so when the view for
            // detail view controller loads, it can access that property to get the feeditem obj
            detailVC.user = user
            detailVC.selectedTopic = selectedItem
        }
        else {
            let detailVC  = segue.destination as! NewTopicViewController
            detailVC.user = user
            detailVC.selectedCategory = selectedCategory
        }
        
    }
}

    



