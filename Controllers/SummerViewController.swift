//
//  SummerViewController.swift
//  JobApp
//
//  Created by Muneeba Khatoon on 7/11/17.
//  Copyright © 2017 Muneeba Khatoon. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CheatyXML

class SummerViewController: UIViewController, UISearchResultsUpdating, UISearchControllerDelegate{
    
   
    @IBOutlet weak var tableView: UITableView!
    var jobsArray: [JobPost] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url: String = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=summer&start=&limit=200&l=&v=2"
        
        //searchbar stuff
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
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
            self.tableView.reloadData()
            
        })
        
    }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // 1
            if let identifier = segue.identifier {
                // 2
                if identifier == "cellPressed" {
                    let indexPath = tableView.indexPathForSelectedRow
    
                    let post = jobsArray[(indexPath?.row)!]
    
                    let detailedViewController = segue.destination as! DetailedViewController
                    detailedViewController.post = post
    
                }
            }
        }
    
    func didDismissSearchController(_ searchController: UISearchController)
    {
        self.jobsArray.removeAll()
        let url: String = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=summer&start=&limit=200&l=&v=2"
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
            self.tableView.reloadData()
            
        })
    }
}

extension SummerViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //  print(jobsArray.count)
        return jobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spPostsCell", for: indexPath) as! SpPostsCell
        
        let post = jobsArray[indexPath.row]
        
        
        cell.jobNameLabel.text = post.jobName
        cell.compNameLabel.text = post.compName
        cell.locationLabel.text = post.location
        
        return cell
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let userSearch: String = searchController.searchBar.text ?? "summer"
        
        let url: String = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=\(userSearch)&start=&limit=200&l=&v=2"
        
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
            self.tableView.reloadData()
            
        })
        
    }
    
    
}
