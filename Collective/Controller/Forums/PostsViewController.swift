//
//  PostsViewController.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/11/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation
import UIKit

class PostsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NetworkProtocol {
    
    var user: User = User()
    var selectedTopic : Topic = Topic()
    var feedItems: NSArray = NSArray()
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var topicHeadline: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        topicHeadline.text = selectedTopic.topic_subject ?? "ERROR"
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let posts = Posts()
        posts.delegate = self
        posts.downloadItems(post_topic: selectedTopic.topic_id)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let posts = Posts()
        posts.delegate = self
        posts.downloadItems(post_topic: selectedTopic.topic_id)
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
        let cellIdentifier: String = "PostCell"
        let myCell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as! PostTableViewCell
        // Get the category to be shown
        let item: Post = feedItems[indexPath.row] as! Post
        // Get references to labels of cell
        myCell.setDetails(post: item)
            
        return myCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let detailVC  = segue.destination as! NewPostViewController
        detailVC.user = user
        detailVC.selectedTopic = selectedTopic
    }
}

    




