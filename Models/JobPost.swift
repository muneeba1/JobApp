//
//  JobPost.swift
//  JobApp
//
//  Created by Muneeba Khatoon on 7/11/17.
//  Copyright © 2017 Muneeba Khatoon. All rights reserved.
//

import Foundation
import UIKit
import CheatyXML

class JobPost: NSObject {
    
    var jobName: String?
    var compName: String?
    var location: String?
    var about: String?
    var url: String?
    //var userSearch: String?
    
    init(data: CXMLTag)
    {
        self.jobName = data["jobtitle"].string
        self.compName = data["company"].string
        self.location =  data["formattedLocation"].string
        self.about = data["snippet"].string
        self.url = data["url"].string
        
    }
    
    //init(userSearch: String) {
    //    self.userSearch = userSearch
    //}
}
