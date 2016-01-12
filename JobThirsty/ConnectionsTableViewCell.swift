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
    
    var tableView: PFQueryTableViewController!
    var connectionObject: PFObject!
    
    @IBOutlet weak var connectionName: UILabel!
    @IBOutlet weak var profileImage: PFImageView!
    
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func pressButtonConnectionAccept(sender: AnyObject) {

        connectionObject["handshake"] = true
        connectionObject.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("successfully accepted connection")
            } else {
                // There was a problem, check error.description
                print("<ERROR> error occurred when accepting connection")
            }
        }
        self.tableView.loadObjects()
    }

    @IBAction func pressButtonConnectionReject(sender: AnyObject) {

        connectionObject.deleteInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("successfully rejected connection")
            } else {
                // There was a problem, check error.description
                print("<ERROR> error occurred when rejecting connection")
            }
        }
        self.tableView.loadObjects()
    }
}
