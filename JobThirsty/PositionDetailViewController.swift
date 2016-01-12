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
    
    var currentObject : PFObject?
    
    @IBOutlet weak var positionTitleLabel: UILabel!
    @IBOutlet weak var companyTitleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Unwrap the current object object
        if let object = currentObject {
            
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
