//
//  SavedPostsTableViewCell.swift
//  JobApp
//
//  Created by Muneeba Khatoon on 8/10/17.
//  Copyright © 2017 Muneeba Khatoon. All rights reserved.
//

import UIKit

class SavedPostsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var jobNameLabel: UILabel!
    
    @IBOutlet weak var compNameLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
