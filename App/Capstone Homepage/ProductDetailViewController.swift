//
//  ProductDetailViewController.swift
//  Capstone Homepage
//
//  Created by Dollar, Mitch on 4/7/19.
//  Copyright © 2019 Austin Rodgers. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    var productName = String()
    
    
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var productText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productText.text = self.productName;
        //Encode for spaces in URL
        guard let fixedProduct:String = productName.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            else {
                print("optional")
                return
        }
        print("This is the fixed product")
        
        print("Right here^")
        
        guard let myUrl = URL(string: "http://cgi.sice.indiana.edu/~team13/productDetail.php?product=\(fixedProduct)") else{ return }
        let session = URLSession.shared
        session.dataTask(with: myUrl) { (data, response, error) in
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                print(dataString)
                let resultString = dataString as String
                let info = resultString.components(separatedBy: "/")
                print(info)
                DispatchQueue.main.async {
                    self.descriptionText.text = info[0];
                    self.cost.text = info[1];
                    
                }
                
            }
            }.resume()
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    



}
