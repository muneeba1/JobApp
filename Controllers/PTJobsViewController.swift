//
//  PTJobsViewController.swift
//  JobApp
//
//  Created by Muneeba Khatoon on 7/11/17.
//  Copyright © 2017 Muneeba Khatoon. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CheatyXML

class PTJobsViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var userSearch: String = "Cashier"
        //var userLocation: String = "Chicago"
        
        var url: String = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=\(userSearch)&l=austin%2C+tx&v=2"
        
        Alamofire.request(url).validate().responseData(completionHandler: { (response) in
            
            let data: CXMLParser! = CXMLParser(data: response.data)
            
            print(data["query"].string)
          //  print(data["results"]["result"][0]["formattedLocation"].string)
            
            var object = JobPost(data: data)
            
        })
        
    }
}
