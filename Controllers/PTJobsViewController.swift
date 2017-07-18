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



class PTJobsViewController: UIViewController, UISearchResultsUpdating, UISearchControllerDelegate{
    
    var jobsArray: [JobPost] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var ptTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url: String = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=part%20&l=&sort=&radius=&st=&jt=parttime&start=&limit=200&fromage=&filter=&latlong=&co=&chnl=&userip=1.2.3.4&useragent=&v=2"
        
        //searchbar stuff
        searchController.searchResultsUpdater = self as! UISearchResultsUpdating
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.ptTableView.tableHeaderView = searchController.searchBar
        searchController.delegate = self
        

        
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
    
    func didDismissSearchController(_ searchController: UISearchController)
    {
        self.jobsArray.removeAll()
        let url: String = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=part%20&l=&sort=&radius=&st=&jt=parttime&start=&limit=200&fromage=&filter=&latlong=&co=&chnl=&userip=1.2.3.4&useragent=&v=2"
        
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
        
        return cell
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let userSearch: String = searchController.searchBar.text ?? "temp"
        
        let url: String = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=part%20&l=&sort=&radius=&st=&jt=parttime&start=&limit=200&fromage=&filter=&latlong=&co=&chnl=&userip=1.2.3.4&useragent=&v=2"
        
        Alamofire.request(url).validate().responseData(completionHandler: { (response) in
            
            let data: CXMLParser! = CXMLParser(data: response.data)
            
            //print(data["query"].string)
            //  print(data["results"]["result"][0]["formattedLocation"].string)
            
            let arrayXML = data["results"]["result"].array
            
            if (arrayXML.count > 0)
            {
                self.jobsArray.removeAll()
                for result in arrayXML {
                    let post = JobPost(data: result)
                    self.jobsArray.append(post)
                    
                }
            }
            
            // var object = JobPost(data: data)
            //self.jobsArray.append(object)
            self.ptTableView.reloadData()
            
        })
        
    }
    
    
}


