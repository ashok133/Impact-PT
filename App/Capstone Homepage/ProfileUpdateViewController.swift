//
//  ProfileUpdateViewController.swift
//  Capstone Homepage
//
//  Created by Dollar, Mitch on 2/6/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

class ProfileUpdateViewController: UIViewController {
    var phoneText = String();
    var emailText = String();
    var addressText = String();
    var userid = String();
    
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var age: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phone.text = self.phoneText
        self.email.text = self.emailText
        self.address.text = self.addressText
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        let enteredPhone : String = phone.text!;
        let enteredEmail : String = email.text!;
        let enteredAddress : String = address.text!;
        print(enteredAddress)
        enteredAddress.replacingOccurrences(of: " ", with: "%20");
        print(enteredAddress)
        let enteredAge : String = age.text!;
        print("update")
        guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/profileupdate.php?userid=1&phone=\(enteredPhone)&address=\(enteredAddress)&email=\(enteredEmail)&age=\(enteredAge)") else{ return }
        let session = URLSession.shared
        session.dataTask(with: myUrl) { (data, response, error) in
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                print(dataString)
                if (dataString.contains("success")){
                    DispatchQueue.main.async {
                        self.displayMessage(userMessage: "Information successfully updated!")
                        
                    }
                    
                }
                else{
                    DispatchQueue.main.async {
                        self.displayMessage(userMessage: "Failed to update" as String)
                    }
                }
            }
            }.resume()
    }

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func displayMessage(userMessage:String) -> Void {
        //Error message Alert documentation from https://developer.apple.com/documentation/uikit/uialertcontroller
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }

}
