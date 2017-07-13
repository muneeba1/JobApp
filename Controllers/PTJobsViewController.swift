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
    
    var jobsArray: [JobPost] = []
    
    @IBOutlet weak var ptTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userLocation: String = "Chicago"
        
        var url: String = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=part%20time&l=chicago%2C+il&v=2"
        
        Alamofire.request(url).validate().responseData(completionHandler: { (response) in
            
            let data: CXMLParser! = CXMLParser(data: response.data)
            
            //print(data["query"].string)
            //  print(data["results"]["result"][0]["formattedLocation"].string)
            
            let arrayXML = data["results"]["result"].array
            
            for result in arrayXML {
                let post = JobPost(data: result)
                self.jobsArray.append(post)
                
            }
            
            // var object = JobPost(data: data)
            //self.jobsArray.append(object)
            self.ptTableView.reloadData()
            
            
        })

    }
}

extension PTJobsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(jobsArray.count)
        return jobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postsCell", for: indexPath) as! PostsTableViewCell
        
        let post = jobsArray[indexPath.row]
        
        cell.jobNameLabel.text = post.jobName
        cell.compNameLabel.text = post.compName
        cell.locationLabel.text = post.location
        
        return cell
    }
    
}
    

