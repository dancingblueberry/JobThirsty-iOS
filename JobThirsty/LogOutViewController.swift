//
//  LogOutViewController.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 1/9/16.
//  Copyright © 2016 Amanda Berryhill. All rights reserved.
//

import UIKit
import Parse

class LogOutViewController: UIViewController {
    
//    @IBOutlet weak var buttonLogout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        print("LOGOUT")
        
        PFUser.logOut()
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("WelcomeViewController") as! WelcomeViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
}

