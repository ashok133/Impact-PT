//
//  PhysicianProgressViewController.swift
//  Capstone Homepage
//
//  Created by Dollar, Mitch on 3/20/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit
import QuartzCore


class PhysicianProgressViewController: UIViewController {
    var userid = String();
    @IBOutlet weak var dateText: UITextField!
    @IBOutlet weak var actionText: UITextField!
    @IBOutlet weak var measurementText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let myColor = UIColor.lightGray
        measurementText.layer.borderColor = myColor.cgColor
        measurementText.layer.borderWidth = 1.0*/

        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        let date : String = dateText.text!;
        let action : String = actionText.text!;
        let measurement : String = measurementText.text!;
        guard let fixedDate:String = date.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            else {
                print("optional")
                return
        }
        guard let fixedAction:String = action.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            else {
                print("optional")
                return
        }
        guard let fixedMeasurement:String = measurement.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            else {
                print("optional")
                return
        }
        
        guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/setProgress.php?userid=\(userid)&actiondate=\(fixedDate)&action=\(fixedAction)&notes=\(fixedMeasurement)") else{ return }
        
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
                        self.displayMessage(userMessage: "Failed to update progress" as String)
                    }
                }
                
            }
            }.resume()
    }
    
    func displayMessage(userMessage:String) -> Void {
        //Error message Alert documentation from https://developer.apple.com/documentation/uikit/uialertcontroller
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
