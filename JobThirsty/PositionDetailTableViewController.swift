//
//  PositionDetailTableViewController.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 1/12/16.
//  Copyright © 2016 Amanda Berryhill. All rights reserved.
//

import UIKit
import ParseUI

class PositionDetailTableViewController: UITableViewController {
    
    var positionObject : PFObject!
    var fromSegueId: String!
    
    @IBOutlet weak var positionTitleLabel: UILabel!
    @IBOutlet weak var companyTitleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Unwrap the current object object
        if let object = positionObject {
            
            if let name = object["positionTitle"] as? String {
                self.positionTitleLabel?.text = name
            }
            
            if let name = object["companyTitle"] as? String {
                self.companyTitleLabel?.text = name
            }
            
            if let name = object["location"] as? String {
                self.locationLabel?.text = name
            }
            
            if let name = object["description"] as? String {
                self.descriptionTextView?.text = name
                let descriptionSize = self.descriptionTextView.text.sizeWithAttributes([NSFontAttributeName:self.descriptionTextView.font!])
                let descriptionHeight = descriptionSize.height;
                var frame = self.descriptionTextView.frame
//                self.descriptionTextView.autoresizesSubviews = true
                frame.size.height = descriptionHeight
                self.descriptionTextView.frame = frame
//                self.description.
            }
            
        }
    }
    
    @IBAction func pressButtonPositionAdd(sender: AnyObject) {
        
//        if (self.positionsSegmentedControl.selectedSegmentIndex == 0) {
        if (fromSegueId == "BrowseToDetail") {
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
        } else {
            // nothing happens
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
