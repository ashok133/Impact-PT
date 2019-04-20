//
//  PhysicianExercisesViewController.swift
//  Capstone Homepage
//
//  Created by Imburgia, Joseph Thomas on 2/25/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

class PhysicianExercisesViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    var userid = String();

    
    @IBOutlet weak var durationText: UITextField!
    @IBOutlet weak var repsText: UITextField!
    @IBOutlet weak var timesText: UITextField!
    
    @IBOutlet weak var exerciseText: UITextField!
    var values: [String] = []
    
    @IBOutlet weak var exerciseDropdown: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.values.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titleRow = (values[row])
        
        return titleRow
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if values.count > 0 && values.count >= row{
            self.exerciseText.text = self.values[row]
            self.exerciseDropdown.isHidden = true
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.exerciseText{
            self.exerciseDropdown.isHidden = false
        }
    }
    override func viewDidLoad() {
        print(userid);
        super.viewDidLoad()
        guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/selectExercise.php") else{ return }
        let session = URLSession.shared
        session.dataTask(with: myUrl) { (data, response, error) in
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                print(dataString)
                let resultString = dataString as String
                let info = resultString.components(separatedBy: "/")
                for line in info{
                    if line != ""{
                        print(line)
                        self.values.append(line)
                    }
                }
                DispatchQueue.main.async {
                    self.exerciseDropdown.delegate = self;
                    //UIApplication.sharedApplication.networkActivityIndicatorVisable = false
                }
                
            }
            }.resume()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func assignButtonTaped(_ sender: Any) {
        let exercise : String = exerciseText.text!;
        let duration : String = durationText.text!;
        let reps : String = repsText.text!;
        let times : String = timesText.text!;
        guard let fixedExercise:String = exercise.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            else {
                print("optional")
                return
        }
 
        guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/assignExercise.php?userid=\(userid)&exercise=\(fixedExercise)&duration=\(duration)&reps=\(reps)&times=\(times)") else{ return }
        
        let session = URLSession.shared
        session.dataTask(with: myUrl) { (data, response, error) in
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                print(dataString)
                if (dataString.contains("assignedinsertsuccess")){
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                    
                }
                else{
                    DispatchQueue.main.async {
                        self.displayMessage(userMessage: "Failed to assign Exercise" as String)
                    }
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
