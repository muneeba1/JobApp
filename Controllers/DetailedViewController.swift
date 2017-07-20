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
    @IBOutlet weak var titleLabel: UINavigationItem!
    @IBOutlet weak var compNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var applyButton: UIButton!
    
    
    var post: JobPost?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let post = post{
            jobNameLabel.text = post.jobName
            compNameLabel.text = post.compName
            locationLabel.text = post.location
            aboutTextView.text = post.about
            titleLabel.title = post.jobName
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1
        if let identifier = segue.identifier {
            // 2
            if identifier == "applyButtonPressed" {
                
                let urlString = post?.url
                
                let webViewController = segue.destination as! WebViewController
                webViewController.url = urlString
                
            }
        }
    }
    
}
