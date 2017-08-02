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
    
    let indeedUrl = URL(string: "https://www.indeed.com")
    
    @IBOutlet weak var jobNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UINavigationItem!
    @IBOutlet weak var compNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var indeedButton: UIBarButtonItem!
    @IBAction func indeedButtonPressed(_ sender: UIBarButtonItem) {
        UIApplication.shared.open(indeedUrl!)
    }
    
    var post: JobPost?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //indeedButton
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "indeed.png"), for: UIControlState.normal)
        button.addTarget(self, action:#selector(DetailedViewController.callMethod), for: UIControlEvents.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 60, height: 30) //CGRectMake(0, 0, 30, 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    
    }
    
    func callMethod() {
        //do stuff here
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
