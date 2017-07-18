//
//  PostsTableViewCell.swift
//  JobApp
//
//  Created by Muneeba Khatoon on 7/13/17.
//  Copyright © 2017 Muneeba Khatoon. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var jobNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var compNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
