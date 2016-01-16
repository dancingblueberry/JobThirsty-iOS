//
//  PostedPositionTableViewController.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 1/13/16.
//  Copyright © 2016 Amanda Berryhill. All rights reserved.
//

import ParseUI
import UIKit

class PostedPositionTableViewController: PFQueryTableViewController {
    
    var currentUserId:String!
    var positionObject: PFObject!
    
//    @IBOutlet weak var positionsSegmentedControl: UISegmentedControl!
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
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
        
    }
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // Configure the PFQueryTableView
        self.parseClassName = "AppliedWorkers"
        self.textKey = "name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 20
        
        self.currentUserId = PFUser.currentUser()?.objectId
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        
//        var query: PFQuery!

//        // browsing (positions i haven't applied for)
//        if (positionsSegmentedControl.selectedSegmentIndex == 0) {
//            query = PFQuery(className: "Position")
//            query.whereKey("appliedArray", notEqualTo: currentUserId)
//        }
//            // viewing applied (positions i've applied for)
//        else if (positionsSegmentedControl.selectedSegmentIndex == 1) {
//            query = PFQuery(className: "AppliedWorkers")
//            query.whereKey("applicantId", equalTo: currentUserId)
//        }
//            // viewing posted (positions i've posted)
//        else {
//            query = PFQuery(className: "Position")
//            query.whereKey("bossId", equalTo: currentUserId)
//        }
        
        let query = PFQuery(className: "AppliedWorkers")
        query.whereKey("positionId", equalTo: positionObject.objectId!)
        
        return query
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        //        let cellIdentifier = "PositionCell"
        var cellIdentifier: String!
//        if (positionsSegmentedControl.selectedSegmentIndex == 0) {
//            cellIdentifier = "PositionCell"
//        } else if (positionsSegmentedControl.selectedSegmentIndex == 1) {
//            cellIdentifier = "AppliedCell"
//        } else {
//            cellIdentifier = "PostedCell"
//        }
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! PositionTableViewCell!
        
//        // Extract values from the PFObject to display in the table cell
//        cell.positionObject = object
//        cell.positionsSegmentedControl = self.positionsSegmentedControl
//        
//        
//        let positionTitle = object!["positionTitle"] as! String
//        let companyTitle = object!["companyTitle"] as! String
//        let location = object!["location"] as! String
//        
//        cell.positionTitleLabel.text = positionTitle
//        cell.companyTitleLabel.text = companyTitle
//        cell.locationLabel.text = location
//        
//        // applied positions
//        if (positionsSegmentedControl.selectedSegmentIndex == 1) {
//            if (!(object!["responded"] as! Bool)) {
//                cell.imageButton.imageView?.image = UIImage(named: "Question-Teal-50")
//            } else if (object!["rejected"] as! Bool) {
//                cell.imageButton.imageView?.image = UIImage(named: "Sad-Teal-50")
//            } else {
//                cell.imageButton.imageView?.image = UIImage(named: "Happy-Teal-50")
//            }
//            //            cell.imageButton
//        }
        
        return cell
    }
    
    @IBAction func connectionsSegmentedControlValueChanged(sender: AnyObject) {
        
        self.loadObjects()
    }
    
    
}
