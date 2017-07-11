//
//  JobPost.swift
//  JobApp
//
//  Created by Muneeba Khatoon on 7/11/17.
//  Copyright © 2017 Muneeba Khatoon. All rights reserved.
//

import Foundation
import UIKit

class JobPost: NSObject {
    
    var jobName: String
    var compName: String
    var location: String
    var compensation: Float
    
    var resp: String
    var qualifications: String
    
    init(jobTitle: Date, compName: String, location: String, compensation: Float, resp: String, qualifications: String)
    {
        self.jobName = ""
        self.compName = compName
        self.location =  location
        self.compensation = compensation
        
        self.resp = resp
        self.qualifications = qualifications
    }
    
}
