//
//  NewsfeedTableViewCell.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 12/19/15.
//  Copyright © 2015 Amanda Berryhill. All rights reserved.
//

import UIKit
import ParseUI

class NewsfeedTableViewCell: PFTableViewCell {
    
    @IBOutlet weak var profileImage1: PFImageView!
    @IBOutlet weak var profileImage2: PFImageView!
    @IBOutlet weak var updateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}