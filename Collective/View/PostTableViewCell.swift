//
//  PostTableViewCell.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/12/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation
import UIKit

class PostTableViewCell: UITableViewCell {
    
    var post: Post = Post()
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setDetails(post: Post?) {
        guard let post = post else {
            print ("EMPTY POST RECEIVED")
            return
        }
        self.post = post
        self.usernameLabel.text = "\(post.post_by_name) #\(post.post_by ?? 0)"
        self.postBody.text = post.post_content ?? "EMPTY"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

