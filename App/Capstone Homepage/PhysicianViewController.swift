//
//  PhysicianViewController.swift
//  Capstone Homepage
//
//  Created by Dollar, Mitch on 2/13/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

class PhysicianViewController: UIViewController {
    
    var userid = String()

    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "PhysicianCalendar"{
            let vc = segue.destination as! PhysicianCalendarViewController
            //Send variables to other view controller from PhP
            vc.userid = self.userid
        }
    }

}
