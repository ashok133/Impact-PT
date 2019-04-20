//
//  PhysicianProductViewController.swift
//  Capstone Homepage
//
//  Created by Imburgia, Joseph Thomas on 2/25/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

class PhysicianProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var userid = String();
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    var nameList:[String] = []
    var index = 0
    var userinfo:[String] = []
    var products = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/viewproducts.php?userid=\(userid)") else{ return }
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
    }
    
    // Do any additional setup after loading the view.
    
    
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddProducts"{
            let vc = segue.destination as! PhysicianEditProductsViewController
            //Send variables to other view controller from PhP
            vc.userid = self.userid
            
        }
    }
    }
    



