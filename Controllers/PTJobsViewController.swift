//
//  PTJobsViewController.swift
//  JobApp
//
//  Created by Muneeba Khatoon on 7/11/17.
//  Copyright © 2017 Muneeba Khatoon. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CheatyXML
import MapKit
import ModernSearchBar


class PTJobsViewController: UIViewController, ModernSearchBarDelegate{
    
    @IBOutlet weak var modernSearchBar: ModernSearchBar!
    @IBOutlet weak var ptTableView: UITableView!
    
    @IBOutlet weak var jtSearchBar: UISearchBar!
    
    var jobsArray: [JobPost] = []
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    let scrollView = UIScrollView()
    
    var url: String = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=part&start=&limit=25&jt=parttime&l=&v=2"
    
    //url variables
    var userSearch: String = ""
    var city: String = ""
    var state: String = ""
    var start: Int = 0
    
    var suggestionList = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        definesPresentationContext = true
        
        //modernsearchbar
        self.modernSearchBar.delegateModernSearchBar = self
        searchCompleter.delegate = self as! MKLocalSearchCompleterDelegate
        //self.modernSearchBar.barTintColor = UIColor.white
        self.modernSearchBar.suggestionsView_searchIcon_isRound = true
        
        //keywordSB Icon
        let textField = jtSearchBar.value(forKey: "searchField") as! UITextField
        let glassIconView = textField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        glassIconView.tintColor = UIColor.green
        
        modernSearchBar.setImage(UIImage(named: "location"), for: .search, state: .normal)
        
        //navigation Bar
        self.navigationController?.navigationBar.tintColor = UIColor.white
        if let font = UIFont(name: "Futura", size: 20) {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font]
        }
        
        //scrollview stuff
        self.scrollView.delegate = self
        
        //viewdidload
        loadData(url: url)
        
        ptTableView.rowHeight = UITableViewAutomaticDimension
        ptTableView.estimatedRowHeight = 80
        
    }
    
    func loadData(url: String){
        
        Alamofire.request(url).validate().responseData(completionHandler: { (response) in
            switch response.result {
            case .success:
                print("Request Successful")
                
                let data: CXMLParser! = CXMLParser(data: response.data)
                
                let arrayXML = data["results"]["result"].array
                
                // print("\n\nNumber of Results:", arrayXML.count)
                
                for result in arrayXML {
                    let post = JobPost(data: result)
                    self.jobsArray.append(post)
                }
                self.ptTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
            
        })
    }
    
    func createURL() {
        
        var location: String = ""
        
        var query: String = "part"
        
        // Increase the starting position for querying api
        self.start += 25
        
        if self.city == ""{
            location = ""
        }else{
            location = self.city + "%2C" + self.state
        }
        
        //  self.url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        
        if self.userSearch == ""{
            query = "part"
        }else{
            query = self.userSearch.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            // query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        }
        print("search stuff city \(self.city) state \(self.state) search \(self.userSearch)")
        self.url = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=\(query)&start=\(self.start)&limit=25&jt=parttime&l=\(location)&v=2"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1
        
        if let identifier = segue.identifier {
            // 2
            if identifier == "labelPressed" {
                let indexPath = ptTableView.indexPathForSelectedRow
                
                let post = jobsArray[(indexPath?.row)!]
                
                let detailedViewController = segue.destination as! DetailedViewController
                detailedViewController.post = post
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ptTableView.reloadData()
    }
    
    //locationBar cancel button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.jobsArray.removeAll()
        self.url = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=part&start=&limit=25&jt=parttime&l=&v=2"
        loadData(url: url)
        searchBar.text = ""
        modernSearchBar.showsCancelButton = false
        searchBar.showsCancelButton = false
    }
}
//locationsearchbar
extension PTJobsViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchResults = completer.results
        
        for location in completer.results
        {
            let locationName  = location.title
            
            if locationName.contains(",") && !suggestionList.contains(locationName)
            {
                suggestionList.append(locationName)
            }
            
        }
        self.modernSearchBar.setDatas(datas: suggestionList)
        
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error)
    {
        print("Could not find location")
    }
}


//tableview stuff
extension PTJobsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("jobsArray: \(jobsArray.count)")
        return jobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postsCell", for: indexPath) as! PostsTableViewCell
        
        let post = jobsArray[indexPath.row]
        
        cell.jobNameLabel.text = post.jobName
        cell.compNameLabel.text = post.compName
        cell.locationLabel.text = post.location
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searchResults.count >= 1 {
            
            let completion = self.searchResults[indexPath.row]
            
            let searchRequest = MKLocalSearchRequest(completion: completion)
            let search = MKLocalSearch(request: searchRequest)
            search.start { (response, error) in
                let coordinate = response?.mapItems[0].placemark.coordinate
                print(String(describing: coordinate))
            }
        }
    }
    
    //location searchbar
    func onClickItemSuggestionsView(item: String) {
        
        let item = item.components(separatedBy: ",")
        
        self.city = item[0].removeWhitespace()
        print(city)
        self.state = item[1].trimmingCharacters(in: .whitespaces)
        
        self.createURL()
        
        self.jobsArray.removeAll()
        loadData(url: self.url)
    }
}


//scrollview
extension PTJobsViewController: UIScrollViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        self.createURL()
        
        loadData(url: self.url)
        
    }
}

//removing space
extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
}

extension PTJobsViewController: UISearchBarDelegate
{
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
    {
        if searchBar == self.modernSearchBar
        {
            //location stuff
        }
        else
        {
            //job search
            //self.searchController.isActive = false
            // self.searchController.dismiss(animated: true, completion: nil)
            
        }
    }
    
    func searchBar(_ searchBar: ModernSearchBar, textDidChange searchText: String)
    {
        
        if searchBar == self.modernSearchBar
        {
            searchCompleter.queryFragment = searchText
        }
        else
        {
            self.userSearch = searchBar.text!
            
            self.createURL()
            
            Alamofire.request(self.url).validate().responseData(completionHandler: { (response) in
                
                let data: CXMLParser! = CXMLParser(data: response.data)
                
                let arrayXML = data["results"]["result"].array
                
                if (arrayXML.count > 0)
                {
                    self.jobsArray.removeAll()
                    for result in arrayXML {
                        let post = JobPost(data: result)
                        self.jobsArray.append(post)
                    }
                }
                self.ptTableView.reloadData()
                print("COUNT \(self.jobsArray.count)")
                print(self.start)
            })
            
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool
    {
        if searchBar == self.modernSearchBar
        {
        modernSearchBar.showsCancelButton = true
        }
        else
        {
         searchBar.showsCancelButton = true
        }
        
        return true
    }

}



