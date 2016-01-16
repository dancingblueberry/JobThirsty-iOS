//
//  ProfileViewController.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 1/12/16.
//  Copyright © 2016 Amanda Berryhill. All rights reserved.
//

import UIKit
import ParseUI

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var whyVisitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whyVisitLabel.text = "London is a world itself. Whether you enjoy visiting historical landmarks or more modern day attractions, there is something for everyone."
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
