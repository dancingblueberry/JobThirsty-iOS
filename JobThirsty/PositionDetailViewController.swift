//
//  PositionDetailViewController.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 1/10/16.
//  Copyright © 2016 Amanda Berryhill. All rights reserved.
//

import UIKit
import Parse

class PositionDetailViewController: UIViewController {
    
    var positionObject : PFObject?
    var fromSegueId: String?
    
    @IBOutlet weak var positionTitleLabel: UILabel!
    @IBOutlet weak var companyTitleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Unwrap the current object object
        if let object = positionObject {
            
            if let positionTitle = object["positionTitle"] as? String {
                self.positionTitleLabel?.text = positionTitle
            }
            
            if let companyTitle = object["companyTitle"] as? String {
                self.companyTitleLabel?.text = companyTitle
            }
            
            if let location = object["location"] as? String {
                self.locationLabel?.text = location
            }
            
            if let description = object["description"] as? String {
                self.descriptionTextView?.text = description
                self.descriptionLabel.text = description
            }
            
            //            if let time = object["time"] as? NSDate {
            //                let dateFormatter = NSDateFormatter()
            //                dateFormatter.dateFormat = "M/d hh:mm"
            //                let dateString = dateFormatter.stringFromDate(time)
            //                self.alarm_time?.text = dateString
            //            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
