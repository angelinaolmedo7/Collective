//
//  NewTopicViewController.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/11/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import Foundation
import UIKit

class NewTopicViewController: UIViewController {
    
    var selectedCategory : Category = Category()
    
    var user: User = User()
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createButton.isEnabled = true
        createButton.setTitle("Creating topic...", for: .disabled)
        print(selectedCategory.cat_name as Any)
    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        createTopicInDB()
    }
    
    func createTopicInDB() {
        createButton.isEnabled = false
        
        let urlPath = "http://www.collectiveapp.site/newtopic.php"
        
        var request = URLRequest(url: URL(string: urlPath)!)
        request.httpMethod = "POST"
        
        var dataString = ""
        
        // the POST string has entries separated by &
        dataString = dataString + "&topic_subject=\(subjectTextField.text ?? "NO SUBJECT")"
        dataString = dataString + "&topic_cat=\(selectedCategory.cat_id!)"
        dataString = dataString + "&topic_by=\(user.user_id!)"
        
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
                        print(returnedData as Any)
                        DispatchQueue.main.async {
                        self.navigationController!.popViewController(animated: true)
                        }
                    }
                }
            }
            uploadJob.resume()
        }
    }


}



