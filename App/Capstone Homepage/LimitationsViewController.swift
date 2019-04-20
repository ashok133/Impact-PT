//
//  LimitationsViewController.swift
//  Capstone Homepage
//
//  Created by Imburgia, Joseph Thomas on 2/25/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

class LimitationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
     var userid = String();
    var nameList:[String] = []
    var recoveryList:[String]=[]
    var index = 0
    
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/viewlimitations.php?userid=\(userid)") else{ return }
        let session = URLSession.shared
        session.dataTask(with: myUrl) { (data, response, error) in
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                print(dataString)
                let resultString = dataString as String
                if resultString.contains("fail"){
                    print("fail")
                }
                else{
                    let info = resultString.components(separatedBy: "/")
                    for line in info{
                        if line != ""{
                            print(line)
                            self.nameList.append(line)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        //UIApplication.sharedApplication.networkActivityIndicatorVisable = false
                    }}
                
            }
            print(self.nameList)
            }
            .resume()
        //Recovery
        guard let myUrl2 = URL(string: "http://cgi.sice.indiana.edu/~team13/viewrecovery.php?userid=\(userid)") else{ return }
        let session2 = URLSession.shared
        session2.dataTask(with: myUrl2) { (data, response, error) in
            if let dataString2 = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                print(dataString2)
                let resultString2 = dataString2 as String
                if resultString2.contains("fail"){
                    print("fail")
                }
                else{
                    let info2 = resultString2.components(separatedBy: "/")
                    for line2 in info2{
                        if line2 != ""{
                            print(line2)
                            self.recoveryList.append(line2)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView2.reloadData()
                        //UIApplication.sharedApplication.networkActivityIndicatorVisable = false
                    }}
                
            }
            print(self.recoveryList)
            }
            .resume()
        
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        print("count")
        var count:Int?
        if tableView == self.tableView {
            print(self.nameList.count)
            count = self.nameList.count
        }
        if tableView == self.tableView2 {
            print(self.recoveryList.count)
            count = self.recoveryList.count
        }
        return count!
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        if tableView == self.tableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
            cell!.textLabel!.text = self.nameList[indexPath.row];
        }
        if tableView == self.tableView2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as UITableViewCell
            cell!.textLabel!.text = self.recoveryList[indexPath.row];
        }
        //self.menuItems[indexPath.row].city
        //titleLab.text = menuItems[indexPath.row].days
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        
    }

}
