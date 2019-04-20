//
//  AddExerciseViewController.swift
//  Capstone Homepage
//
//  Created by Dollar, Mitch on 3/18/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

class AddExerciseViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let name : String = nameField.text!;
        let desc : String = descriptionField.text!;
        guard let fixedName:String = name.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            else {
                print("optional")
                return
        }
        guard let fixedDesc:String = desc.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            else {
                print("optional")
                return
        }
    guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/addExercise.php?name=\(fixedName)&description=\(fixedDesc)") else{ return }
    let session = URLSession.shared
    session.dataTask(with: myUrl) { (data, response, error) in
    if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
    {
    print(dataString)
    let resultString = dataString as String
        if (resultString.contains("success")){
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
    
    }
    .resume()
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
    }

}
