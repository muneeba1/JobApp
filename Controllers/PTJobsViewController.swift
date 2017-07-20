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
    
    let scrollView = UIScrollView()
    let searchController = UISearchController(searchResultsController: nil)
    var start: Int = 0
    
    @IBOutlet weak var ptTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url: String = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=part&start=&limit=25&jt=parttime&l=&v=2"
        
        //searchbar stuff
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.ptTableView.tableHeaderView = searchController.searchBar
        searchController.delegate = self
        
        //styling searchbar
        searchController.searchBar.barTintColor = UIColor.white
        
        let textField = searchController.searchBar.value(forKey: "searchField") as! UITextField
        
        let glassIconView = textField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        glassIconView.tintColor = UIColor.green
        
        
        //scrollview stuff
        self.scrollView.delegate = self
        
        loadData(url: url)
        
        ptTableView.rowHeight = UITableViewAutomaticDimension
        ptTableView.estimatedRowHeight = 80
    }
    
    func loadData(url: String){
        Alamofire.request(url).validate().responseData(completionHandler: { (response) in
            
            let data: CXMLParser! = CXMLParser(data: response.data)
            
            let arrayXML = data["results"]["result"].array
            
            for result in arrayXML {
                let post = JobPost(data: result)
                self.jobsArray.append(post)
                
            }
            
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
    override func viewDidAppear(_ animated: Bool) {
        
        ptTableView.reloadData()
        
    }
    //cancel button stuff
    func didDismissSearchController(_ searchController: UISearchController)
    {
        self.jobsArray.removeAll()
       
        let url: String = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=part&start=&limit=25&jt=parttime&l=&v=2"
        
        loadData(url: url)
    }
}

extension PTJobsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
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
    
   
    //searchbar
    func updateSearchResults(for searchController: UISearchController) {
        
        let userSearch: String = searchController.searchBar.text ?? "temp"
        
        let url: String = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=\(userSearch)&start=&limit=25&jt=parttime&l=&v=2"
      
        Alamofire.request(url).validate().responseData(completionHandler: { (response) in
            
            let data: CXMLParser! = CXMLParser(data: response.data)
            
            
            let arrayXML = data["results"]["result"].array
            
            if (arrayXML.count > 0)
            {
                self.jobsArray.removeAll()
                for result in arrayXML {
                    let post = JobPost(data: result)
                    self.jobsArray.append(post)
                }
            }
            
            
            self.ptTableView.reloadData()
            
        })
        
    }
    
}

//scrollviewdelegate
extension PTJobsViewController: UIScrollViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let userSearch: String = searchController.searchBar.text ?? "temp"
            
        start += 25
        
        if userSearch == ""{
            
            let url = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=part&start=\(start)&limit=25&jt=parttime&l=&v=2"
            
           loadData(url: url)
       
        }else{
            let url = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=\(userSearch)&start=\(start)&limit=25&jt=parttime&l=&v=2"
            
           loadData(url: url)
            
        }
    }
}









