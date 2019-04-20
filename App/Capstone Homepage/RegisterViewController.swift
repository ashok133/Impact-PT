//
//  RegisterViewController.swift
//  Capstone Homepage
//
//  Created by Dollar, Mitch on 1/28/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var mname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    var closer: Int = 0;
    override func viewDidLoad() {
        super.viewDidLoad()

        //   func isValidPassword(testStr:String?) -> Bool {
        //     guard testStr != nil else { return false }
        
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        //   let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        // return passwordTest.evaluate(with: testStr)
        //}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        
        let enteredUsername : String = username.text!;
        let enteredPassword : String = password.text!;
        let enteredFname : String = fname.text!;
        let enteredMname : String = mname.text!;
        let enteredLname : String = lname.text!;
        //validate entered data
        if(username.text?.isEmpty)! ||
            (password.text?.isEmpty)! ||
            (confirmPassword.text?.isEmpty)! ||
            (lname.text?.isEmpty)! ||
            (fname.text?.isEmpty)!{
            DispatchQueue.main.async {
                self.displayMessage(userMessage: "Fill in required fields")
                self.closer = 0;
            }
            
            return
        }
        //Check if passwords are equal
        if ((password.text?.elementsEqual(confirmPassword.text!))! != true) {
            DispatchQueue.main.async {
                self.displayMessage(userMessage: "Passwords must match")}
            self.closer = 0;
            return
        }
        let txt = password.text
        //Check HIPAA compliant passphrase
        if (txt?.rangeOfCharacter(from: CharacterSet.uppercaseLetters) == nil) || (txt?.rangeOfCharacter(from: CharacterSet.lowercaseLetters) == nil) || (txt?.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil) || txt!.count < 8 {
            DispatchQueue.main.async {
                self.displayMessage(userMessage: "Invalid password")}
            self.closer = 0;
            return}
        
        guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/register.php?username=\(enteredUsername)&password=\(enteredPassword)&fname=\(enteredFname)&mname=\(enteredMname)&lname=\(enteredLname)") else{ return }
        
        let session = URLSession.shared
        session.dataTask(with: myUrl) { (data, response, error) in
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                print(dataString)
                if (dataString.contains("userinsertsuccess") && dataString.contains("logininsertsuccess")){
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                    if (self.closer == 1){
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.displayMessage(userMessage: "Failed to register" as String)
                    }
                    self.closer = 0;
                }
                
            }
            }.resume()
    }
    
   
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //Alert message for errors
    func displayMessage(userMessage:String) -> Void {
        //Error message Alert documentation from https://developer.apple.com/documentation/uikit/uialertcontroller
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        closer=1;
    }
}
