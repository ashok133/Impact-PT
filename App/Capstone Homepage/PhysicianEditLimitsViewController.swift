//
//  PhysicianEditLimitsViewController.swift
//  Capstone Homepage
//
//  Created by Imburgia, Joseph Thomas on 2/25/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

class PhysicianEditLimitsViewController: UIViewController {
    var userid = String();
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var enterlimits: UITextField!
    
    @IBAction func savelimits(_ sender: Any) {
        let limits : String = enterlimits.text!;
        guard let fixedLimits:String = limits.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            else {
                print("optional")
                return
        }
        guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/limitations.php?userid=\(userid)&limits=\(fixedLimits)") else {return}
        
        let session = URLSession.shared
        session.dataTask(with: myUrl) { (data, response, error) in
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                print(dataString)
                if (dataString.contains("success")){
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                        
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
    @IBAction func cancellimits(_ sender: Any) {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
