//
//  ConnectionsTableViewCell.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 12/18/15.
//  Copyright © 2015 Amanda Berryhill. All rights reserved.
//

import UIKit
import ParseUI

class ConnectionsTableViewCell: PFTableViewCell {
    
    @IBOutlet weak var connectionName: UILabel!
    @IBOutlet weak var profileImage: PFImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
