//
//  PositionsTableViewController.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 12/18/15.
//  Copyright © 2015 Amanda Berryhill. All rights reserved.
//


import ParseUI
import UIKit

class PositionsTableViewController: PFQueryTableViewController {
    
    var currentUserId:String!
    
    override func viewDidAppear(animated: Bool) {
        //        if PFUser.currentUser() == nil {
        //            let storyboard = UIStoryboard(name: "Login", bundle: nil)
        //            let vc = storyboard.instantiateViewControllerWithIdentifier("SignUpInViewController") as! LoginViewController
        //            self.presentViewController(vc, animated: true, completion: nil)
        //        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //        if self.revealViewController() != nil {
        //            menuButton.target = self.revealViewController()
        //            menuButton.action = "revealToggle:"
        //            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using [segue destinationViewController].
        //        let detailScene = segue.destinationViewController as! AlarmsDetailViewController
        
        //        // Pass the selected object to the destination view controller.
        //        if let indexPath = self.tableView.indexPathForSelectedRow {
        //            let row = Int(indexPath.row)
        //            detailScene.currentObject = (objects?[row] as! PFObject)
        //        }
    }
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // Configure the PFQueryTableView
        self.parseClassName = "Position"
        self.textKey = "name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 20
        
        self.currentUserId = PFUser.currentUser()?.objectId
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        
        let query = PFQuery(className: parseClassName!)
        
        return query
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        let cellIdentifier = "PositionsCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! PositionsTableViewCell!
        
        // Extract values from the PFObject to display in the table cell
        if let name = object?["positionTitle"] as? String {
            cell?.positionTitleLabel?.text = name
        }
        
        if let name = object?["companyTitle"] as? String {
            cell?.companyTitleLabel?.text = name
        }
        
        if let name = object?["location"] as? String {
            cell?.locationLabel?.text = name
        }
        
        return cell
    }
    
}


