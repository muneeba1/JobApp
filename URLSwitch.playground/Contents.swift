//: Playground - noun: a place where people can play

import UIKit
import Foundation

enum JobType: String {
    case partTime = "parttime", internship = "intern", summer = "summer"
}

class PTJobsViewController {
    
    var url: String = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=part&start=&limit=25&jt=parttime&l=&v=2"
    
    var userSearch: String?
    var city: String?
    var state: String?
    var jobType: JobType = .partTime
    var paginationStart: Int = 0
    
    // userSearch
    
    // locationSearch
    
    // start point of pagination
    
    func createURL() {
        
        self.url =  "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=\(self.userSearch)&start=\(self.paginationStart)&limit=25&jt=\(self.jobType.rawValue)&l=\(self.city)%2C\(self.state)&v=2"
        
    }
    
    
}

extension PTJobsViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.paginationStart += 25
        
        self.jobType = .internship
        self.userSearch = ""
        self.city = "San Francisco"
        self.state = "CA"
        
        self.url = self.createURL()
        
    }
    
}