//
//  ProfileViewController.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/10/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = (self.presentingViewController as! AuthViewController).user
        usernameLabel.text = user.user_name
    }
    
}
