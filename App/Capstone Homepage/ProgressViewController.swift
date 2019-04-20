//
//  NewViewController.swift
//  Capstone Homepage
//
//  Created by Imburgia, Joseph Thomas on 2/25/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var userid = String();
    var nameList:[String] = []
    var actionList:[String] = []
    var index = 0
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/viewprogress.php?userid=\(userid)") else{ return }
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
                            let seperate = line.components(separatedBy: ":")
                            for part in seperate{
                                if part.contains("-"){
                                    self.nameList.append(part)
                                }
                                else{
                                    self.actionList.append(part)
                                }
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        //UIApplication.sharedApplication.networkActivityIndicatorVisable = false
                    }}
                
            }
            print(self.nameList)
            print(self.actionList)
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
        print(self.nameList.count)
        return self.nameList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = self.nameList[indexPath.row];
        cell.detailTextLabel?.text = self.actionList[indexPath.row];
        //self.menuItems[indexPath.row].city
        //titleLab.text = menuItems[indexPath.row].days
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        
    }

}
