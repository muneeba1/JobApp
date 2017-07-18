//
//  WebViewController.swift
//  JobApp
//
//  Created by Muneeba Khatoon on 7/17/17.
//  Copyright © 2017 Muneeba Khatoon. All rights reserved.
//

import Foundation
import UIKit

class WebViewController: UIViewController, UIWebViewDelegate{
    
  
    @IBOutlet weak var webView: UIWebView!
    
     var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        let urlLoad = URLRequest(url:URL(string:url!)!)
        webView.loadRequest(urlLoad)
        
//        let url = URL(string: self.url!)
//        let requestObj = URLRequest(url: url!)
//        webView.loadRequest(requestObj)
    }
    
}
