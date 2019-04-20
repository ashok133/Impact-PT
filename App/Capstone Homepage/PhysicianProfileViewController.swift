//
//  PhysicianProfileViewController.swift
//  Capstone Homepage
//
//  Created by Imburgia, Joseph Thomas on 2/25/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

struct phyProfileJSON: Decodable {
    let Appointments: [phyAppointments]
    let Users: [phyUsers]
}

struct phyUsers: Decodable {
    let UserID: String
    let FirstName: String
    let LastName: String
}

struct phyAppointments: Decodable {
    let apmtID: String
    let PhysicianID: String
    let apmtDate: String
    let apmtTime: String
    let PatientID: String
}

class PhysicianProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var userid = String();
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nextApmtDate: UILabel!
    @IBOutlet weak var nextApmtTime: UILabel!
    @IBOutlet weak var nextApmtDoc: UILabel!
    
    
    
    var nameList:[String] = []
    var index = 0
    var nameText = String();
    var usernameText = String();
    var phoneText = String();
    var userData: [String:String] = [:]

    override func viewWillAppear(_ animated: Bool) {
        print(userid)
        super.viewDidLoad()
        guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/phyprofile.php?userid=\(userid)") else{ return }
        let session = URLSession.shared
        session.dataTask(with: myUrl) { (data, response, error) in
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                //print(dataString)
                let resultString = dataString as String
                let info = resultString.split(separator: "/").map{ String($0) }
                self.nameText = info[1];
                //print(self.nameText)
                self.usernameText = info[2];
                //print(self.usernameText)
                if resultString.contains("fail")
                {
                   // print("")

                }
                else{
                    self.phoneText = info[3];
                    //print(self.phoneText)


                }
                DispatchQueue.main.async {
                    self.name.text = self.nameText;
                    self.username.text = self.usernameText;
                    self.phone.text = self.phoneText;

                }

            }
            }.resume()

        //Previous Injury
        nameList = []
        guard let myUrl2 = URL(string: "http://cgi.sice.indiana.edu/~team13/viewinjury.php?userid=\(userid)") else{ return }
        let session2 = URLSession.shared
        session2.dataTask(with: myUrl2) { (data, response, error) in
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                //print(dataString)
                let resultString = dataString as String
                if resultString.contains("fail"){
                    print("fail")
                }
                else{
                    let info = resultString.components(separatedBy: "/")
                    for line in info{
                        if line != ""{
                            //print(line)
                            self.nameList.append(line)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        //UIApplication.sharedApplication.networkActivityIndicatorVisable = false
                    }}
                
            }
            //print(self.nameList)
            }
            .resume()
        guard let url3 = URL(string: "http://cgi.sice.indiana.edu/~team13/profileNextApmt.php?userid=\(userid)") else { return }
        URLSession.shared.dataTask(with: url3) { (data3, response3, err3) in
            guard let data = data3 else { return }
            
            do {
                let responseJSON = try JSONDecoder().decode(phyProfileJSON.self, from: data)
                for user in responseJSON.Users {
                    self.userData[user.UserID] = "\(user.FirstName) \(user.LastName)"
                }
                for apmt in responseJSON.Appointments {
                    
                        DispatchQueue.main.async {
                            self.nextApmtDate.text = apmt.apmtDate
                            self.nextApmtTime.text = apmt.apmtTime
                            self.nextApmtDoc.text = self.userData[apmt.PhysicianID]
                        }
                    
                }
            } catch {
                print("error decoding JSON")
            }
        }.resume()
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileUpdate"{
            let vc = segue.destination as! UpdateProfileViewController
            //Send variables to other view controller from PhP
            vc.phoneText = self.phoneText

        }
        else if segue.identifier == "PhysicianExercise"{
            let vc = segue.destination as! PhysicianExercisesViewController
            //Send variables to other view controller from PhP
            vc.userid = self.userid

        }
        else if segue.identifier == "SetLimits"{
            let vc = segue.destination as! PhysicianSetLimitsViewController
            //Send variables to other view controller from PhP
            vc.userid = self.userid
            
        }
        else if segue.identifier == "PhysicianProgress"{
            let vc = segue.destination as! PhysicianProgressViewController
            //Send variables to other view controller from PhP
            vc.userid = self.userid
            
        }
        else if segue.identifier == "viewProducts"{
            let vc = segue.destination as! PhysicianProductViewController
            //Send variables to other view controller from PhP
            vc.userid = self.userid
            
        }
        else if segue.identifier == "Injury"{
            let vc = segue.destination as! PreviousInjuryViewController
            //Send variables to other view controller from PhP
            vc.userid = self.userid
            
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        print("count")
        print(self.nameList.count)
        return self.nameList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = self.nameList[indexPath.row];
        //self.menuItems[indexPath.row].city
        //titleLab.text = menuItems[indexPath.row].days
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }




}
