//
//  FavoritesViewController.swift
//  JobApp
//
//  Created by Muneeba Khatoon on 8/9/17.
//  Copyright © 2017 Muneeba Khatoon. All rights reserved.
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController
{
    var jobsArray: [SavedJobs] = []
    {
        didSet
        {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        jobsArray = CoreDataHelper.retrieveJobs()
        
//        //dynamic cell height
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 80
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1
        
        if let identifier = segue.identifier {
            // 2
            if identifier == "savedJobPressed" {
                let indexPath = tableView.indexPathForSelectedRow
                
                let post = jobsArray[(indexPath?.row)!]
                
                let detailedViewController = segue.destination as! DetailedViewController
                detailedViewController.job = post
            }
        }
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return jobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! SavedPostsTableViewCell
        
        let post = jobsArray[indexPath.row]
        
        cell.jobNameLabel.text = post.jobName
        cell.compNameLabel.text = post.compName
        cell.locationLabel.text = post.location
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            //1
            CoreDataHelper.delete(job: jobsArray[indexPath.row])
            //2
            jobsArray = CoreDataHelper.retrieveJobs()
            
        }
    }
    
}
