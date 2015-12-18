//
//  MySignupViewController.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 12/17/15.
//  Copyright © 2015 Amanda Berryhill. All rights reserved.
//

import ParseUI

class MySignUpViewController : PFSignUpViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.view.backgroundColor = UIColor.darkGrayColor()
        
        let logoView = UIImageView(image: UIImage(named:"Logo.png"))
        self.signUpView!.logo = logoView
        
    }
    
}
