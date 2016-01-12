//
//  PositionTableViewCell.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 1/10/16.
//  Copyright © 2016 Amanda Berryhill. All rights reserved.
//

import UIKit
import ParseUI

class PositionTableViewCell: PFTableViewCell {
    
    var positionObject: PFObject!
    var positionsSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var positionTitleLabel: UILabel!
    @IBOutlet weak var companyTitleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func pressButtonPositionAdd(sender: AnyObject) {
        
        print ("VIEWING \(self.positionsSegmentedControl.selectedSegmentIndex)")
        
        if (self.positionsSegmentedControl.selectedSegmentIndex == 0) {
            print("apply for position: " + positionObject.objectId!)
            
            let currentUser = PFUser.currentUser()
            
            let appliedWorkers = PFObject(className:"AppliedWorkers")
            appliedWorkers["positionId"] = positionObject.objectId
            appliedWorkers["bossId"] = positionObject["bossId"]
            appliedWorkers["position"] = positionObject["positionTitle"]
            appliedWorkers["name"] = (currentUser!["firstName"] as! String) + " " + (currentUser!["lastName"] as! String)
            appliedWorkers["location"] = positionObject["location"]
            appliedWorkers["applicantId"] = currentUser?.objectId
            appliedWorkers["rejected"] = false
            appliedWorkers.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    self.positionObject.addUniqueObject((currentUser?.objectId)!, forKey: "appliedArray")
                    self.positionObject.saveInBackground()
                    print("successfully applied for position")
                } else {
                    // There was a problem, check error.description
                    print("error occurred when applying for position")
                }
            }
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        } else if (self.positionsSegmentedControl.selectedSegmentIndex == 1) {
            // nothing happens
        } else {
            
        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
