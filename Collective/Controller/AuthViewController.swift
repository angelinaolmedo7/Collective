//
//  AuthViewController.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/9/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation
import UIKit

class AuthViewController: UIViewController {
    
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.statusLabel.text = ""
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        signInUser()
    }
    
    
    func signInUser() {
        self.statusLabel.text = "Signing in..."
        
        let urlPath = "http://www.collectiveapp.site/signin.php"
        
        var request = URLRequest(url: URL(string: urlPath)!)
        request.httpMethod = "POST"
        
        var dataString = ""
        
        // the POST string has entries separated by &
        dataString = dataString + "&user_name=\(usernameTextField.text ?? "")"
        dataString = dataString + "&user_pass=\(passwordTextField.text ?? "")"
        
        // convert the post string to utf8 format
        let dataD = dataString.data(using: .utf8) // convert to utf8 string
        do
        {
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
                   
                    DispatchQueue.main.async {
                        if let jsonElement = jsonResult as? NSDictionary {
                            if let user_id = jsonElement["user_id"] as? NSString,
                                let user_name = jsonElement["user_name"] as? NSString,
                    //                let uesr_date = jsonElement["user_date"] as? Date,
                                let user_level = jsonElement["user_level"] as? NSString
                            {
                                self.user.user_id = user_id.integerValue
                                self.user.user_name = user_name as String
                    //    //            user.user_date = user_date
                                self.user.user_level = user_level.integerValue
                                   
                            }
                            self.performSegue(withIdentifier: "signin", sender: nil)
                        }
                        else {
                            self.statusLabel.text = "Username and password do not match. Please try again."
                        }
                    }
                }
            }
                task.resume()
        }
    }
}

