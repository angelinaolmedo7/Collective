//
//  CategoriesViewController.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/11/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation
import UIKit

class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NetworkProtocol {
    
    var user: User = User()
    var feedItems: NSArray = NSArray()
    var selectedItem : Category = Category()

    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = (self.presentingViewController as! AuthViewController).user
        
        // Do any additional setup after loading the view.
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let categories = Categories()
        categories.delegate = self
        categories.downloadItems()
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
        let cellIdentifier: String = "CatCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the category to be shown
        let item: Category = feedItems[indexPath.row] as! Category
        // Get references to labels of cell
        myCell.textLabel!.text = item.cat_name
            
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Set selected location to var
        selectedItem = feedItems[indexPath.row] as! Category
        // Manually call segue to detail view controller
        self.performSegue(withIdentifier: "itemSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get reference to the destination view controller
        let detailVC  = segue.destination as! ItemsViewController
        // Set the property to the selected location so when the view for
        // detail view controller loads, it can access that property to get the feeditem obj
        detailVC.user = user
        detailVC.selectedCategory = selectedItem
    }
}

    


