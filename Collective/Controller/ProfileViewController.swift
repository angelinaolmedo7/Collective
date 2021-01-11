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
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user.fetchuser(name: "1")
        
    }
    
}
