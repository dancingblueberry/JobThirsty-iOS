//
//  WelcomeViewController.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 12/17/15.
//  Copyright © 2015 Amanda Berryhill. All rights reserved.
//

import UIKit
import ParseUI

class WelcomeViewController : UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    var logInController: MyLogInViewController!
    var signUpController: MySignUpViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        logInController = MyLogInViewController()
        logInController.signUpController = MySignUpViewController()
        logInController.signUpController?.delegate = self
        logInController.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if ((PFUser.currentUser() == nil)) {
            self.presentViewController(logInController, animated:true, completion: nil)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("tabBarController") as! UITabBarController
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logInViewController(controller: PFLogInViewController, didLogInUser user: PFUser) -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
