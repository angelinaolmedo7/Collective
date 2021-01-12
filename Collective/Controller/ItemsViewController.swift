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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        catLabel.text = selectedCategory.cat_name ?? "NAME"
        
        let items = Items()
        items.delegate = self
        items.downloadItems(item_cat: selectedCategory.cat_id ?? 3)
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

    



