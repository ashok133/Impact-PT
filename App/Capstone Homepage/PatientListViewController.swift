//
//  PatientListViewController.swift
//  Capstone Homepage
//
//  Created by Imburgia, Joseph Thomas on 2/25/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

class PatientListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    var nameList:[String] = []
    var numList:[String] = []
    var index = 0
    var userinfo:[String] = []
    var userID = String()
    var name:[String] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func backButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
    super.viewDidLoad()
    guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/patients.php") else{ return }
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
        self.name = line.components(separatedBy: ":")
        self.nameList.append(self.name[1])
        self.numList.append(self.name[0])
    }
    }
    DispatchQueue.main.async {
    self.tableView.reloadData()
    //UIApplication.sharedApplication.networkActivityIndicatorVisable = false
    }
    print(self.nameList)


    }
    }.resume()

    // Do any additional setup after loading the view.
    }


    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // Return the number of sections.
    return 1

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return the number of rows in the section.
    print("count")
    print(nameList.count)
    return nameList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
    cell.textLabel?.text = self.nameList[indexPath.row];
    //self.menuItems[indexPath.row].city
    //titleLab.text = menuItems[indexPath.row].days
    cell.detailTextLabel?.text = ">";
    //"\(self.menuItems[indexPath.row].inches as! Double)"

    return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    index = indexPath.row
    self.userID = self.numList[index]
    
    performSegue(withIdentifier: "PhysicianProfile", sender: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhysicianProfile"{
            let vc = segue.destination as! PhysicianProfileViewController
            //Send variables to other view controller from PhP
            vc.userid = self.userID

            print("hi")
            print(self.userID)

        }
    }

}
