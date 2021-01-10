//
//  FirstViewController.swift
//  Collective
//
//  Created by Angelina Olmedo on 1/8/21.
//  Copyright © 2021 Angelina Olmedo. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func testButtonPressed(_ sender: Any) {
        uploadData()
    }
    
    func uploadData() {
        let urlPath = "http://www.collectiveapp.site/receive.php"
        
        var request = URLRequest(url: URL(string: urlPath)!)
        request.httpMethod = "POST"
        
        var dataString = ""
        
        // the POST string has entries separated by &
        dataString = dataString + "&item1=\("insert1")" // add items as name and value
        dataString = dataString + "&item2=\("insert2")"
        dataString = dataString + "&item3=\("insert3")"
        dataString = dataString + "&item4=\("insert4")"
        
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
                            let alert = UIAlertController(title: "Upload Didn't Work?", message: "Looks like the connection to the server didn't work. Do you have Internet access?", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                    }
                }
                else
                {
                    if let unwrappedData = data {
                        
                        let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue) // Response from web server hosting the database
                        print(returnedData)
                        if returnedData == "1" // insert into database worked
                        {

                            // display an alert if no error and database insert worked (return = 1) inside the DispatchQueue.main.async
                            DispatchQueue.main.async
                            {
                                let alert = UIAlertController(title: "Upload OK?", message: "Looks like the upload and insert into the database worked.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                        else
                        {
                            // display an alert if an error and database insert didn't work (return != 1) inside the DispatchQueue.main.async
                            DispatchQueue.main.async
                            {
                                let alert = UIAlertController(title: "Upload Didn't Work", message: "Looks like the insert into the database did not work.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
            uploadJob.resume()
        }
    }


}

