//
//  PositionsTableViewCell.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 12/18/15.
//  Copyright © 2015 Amanda Berryhill. All rights reserved.
//

import UIKit
import ParseUI

class PositionsTableViewCell: PFTableViewCell {
    
    @IBOutlet weak var positionTitleLabel: UILabel!
    @IBOutlet weak var companyTitleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
