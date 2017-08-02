//
//  SettingsViewController.swift
//  JobApp
//
//  Created by Muneeba Khatoon on 8/1/17.
//  Copyright © 2017 Muneeba Khatoon. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController
{
    let url = URL(string: "https://icons8.com")
    let indeedUrl = URL(string: "https://www.indeed.com")
    let makeUrl = URL(string: "https://www.makeschool.com")
    
    @IBOutlet weak var thanksButton: UIButton!
    @IBOutlet weak var indeedButton: UIButton!
    @IBOutlet weak var makeButton: UIButton!
    
    
    @IBAction func indeedButtonPressed(_ sender: UIButton)
    {
        UIApplication.shared.open(indeedUrl!)
    }
   
    @IBAction func makeButtonPressed(_ sender: UIButton)
    {
        UIApplication.shared.open(makeUrl!)
    }
    
    @IBAction func thanksButtonPressed(_ sender: Any)
    {
        UIApplication.shared.open(url!)
        
    }
}
