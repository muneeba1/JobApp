//
//  InternshipsViewController.swift
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



class InternshipsViewController: UIViewController, UISearchResultsUpdating, UISearchControllerDelegate, ModernSearchBarDelegate{
    
    //IBOutlets
    @IBOutlet weak var modernSearchBar: ModernSearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    var jobsArray: [JobPost] = []
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    let scrollView = UIScrollView()
    let searchController = UISearchController(searchResultsController: nil)
    
    var url: String = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=intern&start=&limit=25&jt=intern&l=&v=2"
    
    //url variables
    var userSearch: String = ""
    var city: String = ""
    var state: String = ""
    var start: Int = 0
    
    var suggestionList = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //searchbar stuff
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        searchController.delegate = self
        searchController.searchBar.placeholder = "keyword"
        
        //styling searchbar
        searchController.searchBar.barTintColor = UIColor.white
        
        
        //modernsearchbar
        self.modernSearchBar.delegateModernSearchBar = self
        searchCompleter.delegate = self as! MKLocalSearchCompleterDelegate
        self.modernSearchBar.barTintColor = UIColor.white
        
        let textField = searchController.searchBar.value(forKey: "searchField") as! UITextField
        
        let glassIconView = textField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        glassIconView.tintColor = UIColor.green
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        //scrollview stuff
        self.scrollView.delegate = self
        
        //viewdidload
        loadData(url: url)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
    }
    
    func loadData(url: String){
        
        Alamofire.request(url).validate().responseData(completionHandler: { (response) in
            switch response.result {
            case .success:
                print("Request Successful")
                
                let data: CXMLParser! = CXMLParser(data: response.data)
                
                let arrayXML = data["results"]["result"].array
                
                print("\n\nNumber of Results:", arrayXML.count)
                
                for result in arrayXML {
                    let post = JobPost(data: result)
                    self.jobsArray.append(post)
                }
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
            
        })
    }
    
    func createURL() {
        
        var location: String = ""
        
        var query: String = "intern"
        
        // Increase the starting position for querying api
        self.start += 25
        
        if self.city == ""{
            location = ""
        }else{
            location = self.city + "%2C" + self.state
        }
        
        if self.userSearch == ""{
            query = "intern"
        }else{
            query = self.userSearch
        }
        
        self.url = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=\(query)&start=\(self.start)&limit=25&jt=intern&l=\(location)&v=2"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1
        if let identifier = segue.identifier {
            // 2
            if identifier == "cellPressed" {
                let indexPath = tableView.indexPathForSelectedRow
                
                let post = jobsArray[(indexPath?.row)!]
                
                let detailedViewController = segue.destination as! DetailedViewController
                detailedViewController.post = post
                
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //cancel button stuff
    func didDismissSearchController(_ searchController: UISearchController)
    {
        self.jobsArray.removeAll()
        self.url = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=intern&start=&limit=25&jt=intern&l=&v=2"
        loadData(url: url)
    }
}


extension InternshipsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: ModernSearchBar, textDidChange searchText: String) {
        
        searchCompleter.queryFragment = searchText
        modernSearchBar.showsCancelButton = true
    }
    
    //locationBar cancel button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.jobsArray.removeAll()
        self.url = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=part&start=&limit=25&jt=parttime&l=&v=2"
        loadData(url: url)
        
        modernSearchBar.showsCancelButton = false
    }
}

//locationsearchbar
extension InternshipsViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchResults = completer.results
        
        for location in completer.results
        {
            let locationName  = location.title
            suggestionList.append(locationName)
        }
        self.modernSearchBar.setDatas(datas: suggestionList)
        
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}


//tableview stuff
extension InternshipsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return jobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "internPostsCell", for: indexPath) as! InternPostsCell
        
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
    
    
    //searchbar
    func updateSearchResults(for searchController: UISearchController) {
        
        self.userSearch = searchController.searchBar.text!
        
        url = "http://api.indeed.com/ads/apisearch?publisher=2752372751835619&q=\(userSearch)&start=&limit=25&jt=intern&l=&v=2"
        
        let urlEncoder = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        Alamofire.request(urlEncoder!).validate().responseData(completionHandler: { (response) in
            
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
            self.tableView.reloadData()
            
        })
        
    }
    //location searchbar
    func onClickItemSuggestionsView(item: String) {
        
        let item = item.components(separatedBy: ",")
        
        self.city = item[0].removeWhitespace()
        self.state = item[1].trimmingCharacters(in: .whitespaces)
        
        self.createURL()
        
        self.jobsArray.removeAll()
        loadData(url: self.url)
    }
}

//scrollview
extension InternshipsViewController: UIScrollViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        self.createURL()
        
        loadData(url: self.url)
        
    }
}


