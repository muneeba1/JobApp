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
  
    @IBOutlet weak var tableView: UITableView!
    
    var jobsArray: [String] = []
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let jobs = CoreDataHelper.retrieveJobs()
    }
    

}
