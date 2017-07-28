//
//  FavoriteViewController.swift
//  JobApp
//
//  Created by Muneeba Khatoon on 7/28/17.
//  Copyright © 2017 Muneeba Khatoon. All rights reserved.
//

import Foundation
import UIKit

class FavoriteViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //navigationBar
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        if let font = UIFont(name: "Futura", size: 20) {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font]
        }
        
    }
    
    
}
