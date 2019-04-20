//
//  UpdateProfileViewController.swift
//  Capstone Homepage
//
//  Created by Dollar, Mitch on 2/9/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController {
    var phoneText = String();
    var emailText = String();
    var addressText = String();
    var userid = String();
    var closer = String();
    
    @IBOutlet weak var enteredPhone: UITextField!
    @IBOutlet weak var enteredAddress: UITextField!
    @IBOutlet weak var enteredAge: UITextField!
    @IBOutlet weak var enteredEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enteredPhone.text = self.phoneText
        self.enteredEmail.text = self.emailText
        self.enteredAddress.text = self.addressText
        print(userid)
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        print("hi")
        let phone : String = enteredPhone.text!;
        let email : String = enteredEmail.text!;
        let address : String = enteredAddress.text!;
        print(address)
    
        guard let fixedAddress:String = address.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            else {
                print("optional")
                return
        }
        //let fixedAddress = address.replacingOccurrences(of: " ", with: "%20");
        
        print(fixedAddress)
        let age : String = enteredAge.text!;
        guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/profileupdate.php?userid=\(userid)&phone=\(phone)&address=\(fixedAddress)&email=\(email)&age=\(age)") else{ return }
        let session = URLSession.shared
        session.dataTask(with: myUrl) { (data, response, error) in
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                print(dataString)
                if (dataString.contains("success")){
                    DispatchQueue.main.async {
                        
                        self.dismiss(animated: true, completion: nil)
                        
                        
                    }
                    if (self.closer == "done"){
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.displayMessage(userMessage: "Failed to update" as String)
                    }
                    self.closer = ""
                }
            }
            }.resume()
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func displayMessage(userMessage:String) -> Void {
        //Error message Alert documentation from https://developer.apple.com/documentation/uikit/uialertcontroller
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        self.closer = "done"
    }

}
