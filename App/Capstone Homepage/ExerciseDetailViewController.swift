//
//  ExerciseDetailViewController.swift
//  Capstone Homepage
//
//  Created by Dollar, Mitch on 3/7/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

class ExerciseDetailViewController: UIViewController {
    
    var exerciseName = String()
    @IBOutlet weak var exerciseText: UILabel!
    @IBOutlet weak var repsText: UILabel!
    @IBOutlet weak var durationText: UILabel!
    @IBOutlet weak var timesText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseText.text = self.exerciseName;
        //Encode for spaces in URL
        guard let fixedExercise:String = exerciseName.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            else {
                print("optional")
                return
        }
        guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/exerciseDetail.php?exercise=\(fixedExercise)") else{ return }
        let session = URLSession.shared
        session.dataTask(with: myUrl) { (data, response, error) in
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                print(dataString)
                let resultString = dataString as String
                let info = resultString.components(separatedBy: "/")
                DispatchQueue.main.async {
                    self.descriptionText.text = info[0];
                    self.repsText.text = info[1];
                    self.durationText.text = info[2];
                    self.timesText.text = info[3];
                }
                
            }
            }.resume()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
