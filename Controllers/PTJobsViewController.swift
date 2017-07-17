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
        
        //  var userSearch: String = "Cashier"
        //var userLocation: String = "Chicago"
        
        var url: String = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=part%20time&l=&v=2"
        
        
        Alamofire.request(url).validate().responseData(completionHandler: { (response) in
            
            let data: CXMLParser! = CXMLParser(data: response.data)
            
            //            print(data["query"].string)
            //print(data["query"].string)
            //  print(data["results"]["result"][0]["formattedLocation"].string)
            
            // var object = JobPost(data: data)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1
        if let identifier = segue.identifier {
            // 2
            if identifier == "labelPressed" {
                let indexPath = ptTableView.indexPathForSelectedRow
                
                let post = jobsArray[(indexPath?.row)!]
                
                let detailedViewController = segue.destination as! DetailedViewController
                detailedViewController.post = post
                
            }
        }
    }
}

extension PTJobsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //  print(jobsArray.count)
        return jobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postsCell", for: indexPath) as! PostsTableViewCell
        
        let post = jobsArray[indexPath.row]
        
        cell.jobNameLabel.text = post.jobName
        cell.compNameLabel.text = post.compName
        cell.locationLabel.text = post.location
        
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(PTJobsViewController.tapFunction))
//        cell.jobNameLabel.isUserInteractionEnabled = true
//        cell.jobNameLabel.addGestureRecognizer(tap)
        
        return cell
    }
    
//    func tapFunction(sender:UITapGestureRecognizer) {
//        self.performSegue(withIdentifier: "labelPressed", sender: self)
//    }
    
}

