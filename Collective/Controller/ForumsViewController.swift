//
//  ForumsViewController.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/11/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation
import UIKit

class ForumsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol {
    
    var feedItems: NSArray = NSArray()
    var selectedTest: TestTableModel = TestTableModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
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
        let cellIdentifier: String = "BasicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the location to be shown
        let item: TestTableModel = feedItems[indexPath.row] as! TestTableModel
        // Get references to labels of cell
        myCell.textLabel!.text = item.name1
            
        return myCell
    }
}

    


