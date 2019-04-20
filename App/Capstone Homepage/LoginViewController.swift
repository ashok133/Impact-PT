//
//  LoginViewController.swift
//  Capstone Homepage
//
//  Created by Dollar, Mitch on 1/22/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController {
    var userID = String();
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButtonTapped(_ sender: UIButton) {




        let enteredUsername : String = username.text!;
        let enteredPassword : String = password.text!;
        //let dataString: NSString? = "fail";
        guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/login.php?username=\(enteredUsername)&password=\(enteredPassword)") else{ return }
        let session = URLSession.shared
        session.dataTask(with: myUrl) { (data, response, error) in
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                if dataString.contains("success"){
                    /*let mainViewController =
                        self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
                            as! ViewController

                    self.present(mainViewController, animated: true)
                    */
                    let resultString = dataString as String

                    let info = resultString.split(separator: "/").map{ String($0)}
                    self.userID = info[1];
                    let cred=info[2];
                    let verify = info[3];
                    //Send to terms and conditions if not already confirmed
                    if verify == "n"{
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "Terms", sender: self)
                        }
                    }
                    else if verify == "y"{
                        //If terms and conditions are confirmed, check if patient or physician
                        if cred == "cred=0"{
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "PlayerLogin", sender: self)
                            }
                        }
                        else if cred == "cred=1"{
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "PhysicianLogin", sender: self)
                            }
                        }

                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.displayMessage(userMessage: "Login Failed")
                    }
                }

            }
        }.resume()

    }
     @IBAction func registerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "Register", sender: self)
    }

    
    //Send userid to other pages
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlayerLogin"{
            let vc = segue.destination as! ViewController
            //Send variables to other view controller from PhP
            vc.userid = self.userID
        }

        else if segue.identifier == "Terms"{
            let vc = segue.destination as! TermsViewController
            //Send variables to other view controller from PhP
            vc.userid = self.userID
        }
        else if segue.identifier == "PhysicianLogin"{
            let vc = segue.destination as! PhysicianViewController
            //Send variables to other view controller from PhP
            vc.userid = self.userID
        }
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
