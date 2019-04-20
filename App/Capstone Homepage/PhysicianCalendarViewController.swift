//
//  PhysicianCalendarViewController.swift
//  Capstone Homepage
//
//  Created by Mike Laigaard on 3/24/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

class PhysicianCalendarViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return patientPickerData.count
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return patientPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        createPatient.text = patientPickerData[row]
        self.view.endEditing(true)
    }
    
    
    @IBOutlet weak var createDate: UITextField!
    @IBOutlet weak var createTime: UITextField!
    @IBOutlet weak var createPatient: UITextField!
    
    
    let patientPicker = UIPickerView()
    var patientPickerData:[String] = []
    var patientData: [String:String] = [:]
    var patientDataReverse: [String:String] = [:]
    var userid = String()
    var createDateText = String()
    var createTimeText = String()
    var createPatientText = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlP = URL(string: "http://cgi.sice.indiana.edu/~team13/selectPatient.php") else { return }
        let sessionP = URLSession.shared
        sessionP.dataTask(with: urlP) { (dataP, responseP, errorP) in
            if let dataString = NSString(data: dataP!, encoding: String.Encoding.utf8.rawValue) {
                let resultString = dataString as String
                let patientInfo = resultString.components(separatedBy: "/")
                for patient in patientInfo {
                    let p = patient.components(separatedBy: "-")
                    //check to eliminate crash by empty string at end of patientInfo array
                    if p[0] == "" {
                        continue
                    }
                    else {
                        let ID = p[0]
                        let Name = p[1]
                        self.patientPickerData.append(Name)
                        self.patientData[Name] = ID
                        self.patientDataReverse[ID] = Name
                    }
                }
            }
            }.resume()
        
        createPatient.inputView = patientPicker
        patientPicker.delegate = self
        patientPicker.dataSource = self
        let datePicker = UIDatePicker()
        let timePicker = UIDatePicker()
        datePicker.setDate(Date(), animated: false)
        timePicker.setDate(Date(), animated: false)
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: .valueChanged)
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timeChange(timePicker:)), for: .valueChanged)
        createDate.inputView = datePicker
        createTime.inputView = timePicker
        
        // Do any additional setup after loading the view.
    }
    
    @objc
    func dateChange(datePicker:UIDatePicker) {
        let selectedDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let formattedDateString = dateFormatter.string(from: selectedDate)
        createDate.text = formattedDateString
        self.view.endEditing(true)
    }
    
    @objc
    func timeChange(timePicker:UIDatePicker) {
        let selectedTime = timePicker.date
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .medium
        let formattedTimeString = timeFormatter.string(from: selectedTime)
        createTime.text = formattedTimeString
        self.view.endEditing(true)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        if (createDate.text?.isEmpty)! || (createTime.text?.isEmpty)! || (createPatient.text?.isEmpty)! {
            DispatchQueue.main.async {
                self.displayMessage(userMessage: "Please Fill in all Fields")
            }
        }
        else {
            let enteredDate: String = createDate.text!
            let enteredTime: String = createTime.text!
            let enteredPatient: String = createPatient.text!
            
            let dateEncoded: String = enteredDate.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
            let timeEncoded: String = enteredTime.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
            
            let StringPatiendID = patientData[enteredPatient]
            let patientID = String(StringPatiendID!)
            guard let url2 = URL(string: "http://cgi.sice.indiana.edu/~team13/createApmt.php?userid=\(userid)&apmtDate=\(dateEncoded)&apmtTime=\(timeEncoded)&patient=\(patientID)") else { return }
            let session = URLSession.shared
            session.dataTask(with: url2) { (data, response, error) in
                if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
                    if dataString.contains("successfully created appointment") {
                        
                            self.dismiss(animated: true, completion: nil)
                        
                    }
                    else{
                        DispatchQueue.main.async {
                            self.displayMessage(userMessage: "Appointment creation failed")
                    }
                    }
                }
                }.resume()
        }
    }
    

    
    func displayMessage(userMessage:String) -> Void {
        let alert = UIAlertController(title: "Warning", message: userMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { (_) in
            NSLog("The \"OK\" alert occured")
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
