//
//  ViewController.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 12/12/15.
//  Copyright © 2015 Amanda Berryhill. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    
    @IBOutlet weak var buttonTest: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        buttonTest.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonPressed(sender: UIButton) {
//        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.stackoverflow.com")!)

        PFUser.logOut()
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("WelcomeViewController") as! WelcomeViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }

}

