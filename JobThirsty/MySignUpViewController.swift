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
        
//        self.fields = (PFLogInFields) (
//            rawValue:
//            PFLogInFields.UsernameAndPassword.rawValue
//                | PFLogInFields.LogInButton.rawValue
//                | PFLogInFields.SignUpButton.rawValue)
        
        self.fields = (PFSignUpFields) (
            rawValue:
            PFSignUpFields.UsernameAndPassword.rawValue
            | PFSignUpFields.Email.rawValue
            | PFSignUpFields.Additional.rawValue
            | PFSignUpFields.DismissButton.rawValue)
        
    }
    
}
