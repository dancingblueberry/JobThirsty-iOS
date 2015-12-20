//
//  NewsfeedTableViewController.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 12/19/15.
//  Copyright © 2015 Amanda Berryhill. All rights reserved.
//

import ParseUI
import UIKit

class NewsfeedTableViewController: PFQueryTableViewController {
    
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
        self.parseClassName = "Newsfeed"
        self.textKey = "name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 20
        
        self.currentUserId = PFUser.currentUser()?.objectId
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        
        let query = PFQuery(className: parseClassName!)
        query.whereKey("visibleList", containsAllObjectsInArray:[currentUserId])
        query.orderByDescending("createdAt")
        return query
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        let cellIdentifier = "NewsfeedCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! NewsfeedTableViewCell!
        
        // Extract values from the PFObject to display in the table cell
        if let name = object?["update"] as? String {
            cell?.updateLabel?.text = name
        }
        
        let involvedList = object?["involvedList"] as! [String]
        if involvedList.count >= 1 {
            getProfileImage(involvedList[0], profileImage: cell.profileImage1)
        }
        if involvedList.count >= 2 {
            getProfileImage(involvedList[1], profileImage: cell.profileImage2)
        }
        
        return cell
    }
    
    func getProfileImage(userId:String, profileImage:PFImageView) {
        
        let initialThumbnail = UIImage(named: "ProfilePlaceholder")
        profileImage.image = initialThumbnail
        
        let userQuery = PFUser.query()
        userQuery!.getObjectInBackgroundWithId(userId) { (user, error) -> Void in
            let dataQuery = PFQuery(className: "EmployeeData")
            dataQuery.getObjectInBackgroundWithId(user!["dataId"] as! String, block: { (data, error) -> Void in
                if let thumbnail = data!["profileImage"] as? PFFile {
                    profileImage.file = thumbnail
                    profileImage.loadInBackground()
                }
            })
        }
        
    }
    
}


