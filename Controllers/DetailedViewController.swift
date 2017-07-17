//
//  DetailedViewController.swift
//  JobApp
//
//  Created by Muneeba Khatoon on 7/17/17.
//  Copyright © 2017 Muneeba Khatoon. All rights reserved.
//

import Foundation
import UIKit

class DetailedViewController: UIViewController{
    
    
    @IBOutlet weak var jobNameLabel: UILabel!
    @IBOutlet weak var compNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var applyButton: UIButton!
    @IBAction func applyButtonPressed(_ sender: UIButton) {
    }
    
    var post: JobPost?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
      //jobNameLabel.text = post?.jobName
     // print(post?.jobName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let post = post{
            jobNameLabel.text = post.jobName
            compNameLabel.text = post.compName
            locationLabel.text = post.location
            aboutTextView.text = post.about
        }
    }
}
