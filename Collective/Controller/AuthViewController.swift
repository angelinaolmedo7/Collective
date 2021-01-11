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
        dataString = dataString + "&user_name=\(usernameTextField.text!)"
        dataString = dataString + "&user_pass=\(passwordTextField.text!)"
        
        // convert the post string to utf8 format
        let dataD = dataString.data(using: .utf8) // convert to utf8 string
        do
        {
            // the upload task, uploadJob, is defined here
            let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD)  // h8 the name uploadjob change later
            {
                data, response, error in
                if error != nil {
                    // display an alert if there is an error inside the DispatchQueue.main.async
                    DispatchQueue.main.async
                    {
                            let alert = UIAlertController(title: "Connection Failed", message: "Looks like the connection to the server didn't work. Do you have Internet access?", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                    }
                }
                else
                {
                    if let unwrappedData = data {
                        let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue) // Response from web server hosting the database
                        if let returnedData = returnedData {
                            DispatchQueue.main.async { // i think?
                                if returnedData == "1" {
                                    // log in
                                    self.performSegue(withIdentifier: "signin", sender: nil)
                                }
                                else if returnedData == "0"{
                                    // incorrect
                                    self.statusLabel.text = "Username and password do not match. Please try again."
                                }
                                else {
                                    self.statusLabel.text = "Something's gone wrong on our end. Please try again later."
                                }
                            }
                        }
                    }
                }
            }
            uploadJob.resume()
        }
    }
}

