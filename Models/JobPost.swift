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


    init(data: CXMLParser)
    {
        self.jobName = data["results"]["result"][0]["jobtitle"].string
        self.compName = data["results"]["result"][0]["company"].string
        self.location =  data["results"]["result"][0]["formattedLocation"].string
        self.about = data["results"]["result"][0]["snippet"].string

    }
    
}
