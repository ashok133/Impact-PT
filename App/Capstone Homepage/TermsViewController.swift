//
//  TermsViewController.swift
//  Capstone Homepage
//
//  Created by Dollar, Mitch on 2/14/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {
    @IBAction func terms(_ sender: Any) {
        if let url = NSURL(string:"https://app.termly.io/document/terms-of-use-for-website/d409cb75-a3e7-4031-b6aa-7f9e1ee00f6a"){UIApplication.shared.openURL(url as URL)
            
        }
    }
    
    
    var userid = String();
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func accept(_ sender: Any) {
    
    //Send verifcation update to PHP
  
        
        guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/terms.php?UserID=\(self.userid)")else{ return
            }
        
    
        let session = URLSession.shared
        session.dataTask(with: myUrl) { (data, response, error) in
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                print(dataString)
            
                if dataString.contains("success"){
                    DispatchQueue.main.async { self.dismiss(animated: true, completion: nil)
                    }}}}
            .resume()
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}


    

