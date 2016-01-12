//
//  MoreTableViewController.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 12/19/15.
//  Copyright © 2015 Amanda Berryhill. All rights reserved.
//

import UIKit
import Parse

class MoreTableViewController: UITableViewController {
    
    // MARK: - Table view data source
    let tableContents = [["Profile",  "Profile-25",  ""],
                         ["Settings", "Settings-25", ""],
                         ["Logout",   "Exit-25",     "LogOutViewController"]]
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableContents.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MoreCell", forIndexPath: indexPath) as! MoreTableViewCell
        let rowContent = tableContents[indexPath.row]
        cell.label?.text = rowContent[0]
        cell.moreImageView?.image = UIImage(named: rowContent[1])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let row = indexPath.row
        print("SELECT \(tableContents[row][0])")
        let id = tableContents[row][2]

        if (tableContents[row][0] == "Logout") {
            PFUser.logOut()
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("WelcomeViewController") as! WelcomeViewController
            self.presentViewController(vc, animated: true, completion: nil)
        } else if (!id.isEmpty) {
            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier(id)
            self.showViewController(vc as! UIViewController, sender: vc)
        }
    }
    
}
