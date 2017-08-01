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
    
    @IBOutlet weak var thanksButton: UIButton!
    @IBAction func thanksButtonPressed(_ sender: Any)
    {
        UIApplication.shared.open(url!)
        
    }
}
