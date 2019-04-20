//
//  PhysProductsViewController.swift
//  Capstone Homepage
//
//  Created by joey on 3/25/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

class PhysProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    
    @IBOutlet weak var tableView: UITableView!
    
    var nameList:[String] = []
    var index = 0
    
    
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "AddProduct", sender: Any?.self)
    }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        nameList = []
        super.viewDidLoad()
        guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/products.php") else{ return }
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
                        self.nameList.append(line)
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
        //cell.detailTextLabel?.text = ">";
        //"\(self.menuItems[indexPath.row].inches as! Double)"
        
        return cell
        
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
