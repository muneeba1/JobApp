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
        
        var url: String = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=java&l=austin%2C+tx&sort=&radius=&st=&jt=&start=&limit=&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2"
        
        Alamofire.request(url).validate().responseData(completionHandler: { (response) in
            //print(response.result.value)
            
            let data: CXMLParser! = CXMLParser(data: response.data)
            //print(data)
            
            var object = JobPost(data: data)
            
        })
    }
    
    
}
