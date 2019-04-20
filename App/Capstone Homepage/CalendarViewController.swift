//
//  CalendarViewController.swift
//  Capstone Homepage
//
//  Created by Laigaard, Michael John on 2/9/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

struct jsonResponse: Decodable {
    let Physician: [User]
    let Patient: [User]
    let Appointment: [Appointment]
}

struct User: Decodable {
    let UserID: String
    let FirstName: String
    let LastName: String
}

struct Appointment: Decodable {
    let apmtID: String
    let PhysicianID: String
    let apmtDate: String
    let apmtTime: String
    let PatientID: String
}



class CalendarViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return injuryData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return injuryData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        injuryLocation.text = injuryData[row]
        self.view.endEditing(true)
    }
    
    

    @IBOutlet weak var requestDate: UITextField!
    @IBOutlet weak var injuryLocation: UITextField!
    @IBOutlet weak var patientName: UITextField!
    
    
    
    var userid = String()
    var physicianData: [String:String] = [:]
    var requestDateText = String()
    var requestInjuryText = String()
    var currentPatient = ""
    
    let injuryData = ["Neck", "Shoulder", "Upper Back", "Lower Back", "Upper Arm", "Forearm", "Hip", "Upper Leg", "Lower Leg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let injuryPicker = UIPickerView()
        injuryLocation.inputView = injuryPicker
        injuryPicker.delegate = self
        
        let datePicker = UIDatePicker()
        datePicker.setDate(Date(), animated: false)
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: .valueChanged)
        requestDate.inputView = datePicker
        
        
        guard let url = URL(string: "http://cgi.sice.indiana.edu/~team13/patientNextApmt2.php?userid=\(userid)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(jsonResponse.self, from: data)
                for patient in response.Patient {
                    if patient.UserID == self.userid {
                        self.currentPatient = "\(patient.FirstName) \(patient.LastName)"
                        DispatchQueue.main.async {
                            self.patientName.text = self.currentPatient
                        }
                    }
                }
            } catch {
                print("error decoding JSON")
            }
            }.resume()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc
    func dateChange(datePicker:UIDatePicker) {
        let selectedDate = datePicker.date
        let dateFormatterD = DateFormatter()
        dateFormatterD.dateStyle = .long
        let formattedDateString = dateFormatterD.string(from: selectedDate)
        requestDate.text = formattedDateString
        self.view.endEditing(true)
    }
    
    @IBAction func requestTapped(_ sender: UIButton) {
        if (patientName.text?.isEmpty)! || (requestDate.text?.isEmpty)! || (injuryLocation.text?.isEmpty)! {
            DispatchQueue.main.async {
                self.displayMessage(userMessage: "Please fill in all fields")
            }
        }
        else {
            let enteredName: String = self.patientName.text!
            let enteredDate: String = self.requestDate.text!
            let enteredInjury: String = self.injuryLocation.text!
            
            let nameEncoded: String = enteredName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
            let dateEncoded: String = enteredDate.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
            let injuryEncoded: String = enteredInjury.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
            
            guard let url2 = URL(string: "http://cgi.sice.indiana.edu/~team13/patientApmtRequest.php?patientName=\(nameEncoded)&rqstDate=\(dateEncoded)&injuryLocation=\(injuryEncoded)") else { return }
            URLSession.shared.dataTask(with: url2) { (data, response, error) in
                guard let data = data else { return }
                let dataString = String(data: data, encoding: .utf8)
                if (dataString!.contains("successful request")) {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                }.resume()
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
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
/*
 // MARK: - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
