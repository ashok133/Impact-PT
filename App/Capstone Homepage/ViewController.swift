//
//  ViewController.swift
//  Capstone Homepage
//
//  Created by Austin Rodgers on 1/22/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var userid = String();
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userid)
        // Do any additional setup after loading the view, typically from a nib.
        print(userid)
    }
    @IBAction func logoutButtonTapped(_ sender: Any) {
        userid="0";
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func calendarButtonTapped(_ sender: Any) {
          performSegue(withIdentifier: "Calendar", sender: self)
    }
    @IBAction func profileButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "Profile", sender: self)
    }
    //Send userid to other pages
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Profile"{
            let vc = segue.destination as! ProfileViewController
            //Send variables to other view controller from PhP
            vc.userid = self.userid
        }
        else if segue.identifier == "Calendar" {
            let secondVC = segue.destination as! CalendarViewController
            secondVC.userid = userid
            }
        else if segue.identifier == "Exercise" {
            let thirdVC = segue.destination as! ExercisesViewController
            thirdVC.userid = userid
        }
        else if segue.identifier == "playerLimits" {
            let fourthVC = segue.destination as! LimitationsViewController
            fourthVC.userid = userid
        }
        else if segue.identifier == "products" {
            let fourthVC = segue.destination as! ProductViewController
            fourthVC.userid = userid
        }
        else if segue.identifier == "PatientProgress" {
            let fourthVC = segue.destination as! ProgressViewController
            fourthVC.userid = userid
        }
    }
    
    
}

