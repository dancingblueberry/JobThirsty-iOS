//
//  ConnectionsTableViewController.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 12/18/15.
//  Copyright © 2015 Amanda Berryhill. All rights reserved.
//

import ParseUI
import Parse
import UIKit

class ConnectionsTableViewController: PFQueryTableViewController {
    
    @IBOutlet weak var menuButton:UIBarButtonItem!
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
        self.parseClassName = "Connections"
        self.textKey = "name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 20
        
        self.currentUserId = PFUser.currentUser()?.objectId
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        
        let receiverQuery = PFQuery(className: parseClassName!)
        receiverQuery.whereKey("receiverId", equalTo: currentUserId)
        receiverQuery.whereKey("handshake", equalTo: true)
        
        let intenderQuery = PFQuery(className: parseClassName!)
        intenderQuery.whereKey("intenderId", equalTo: currentUserId)
        intenderQuery.whereKey("handshake", equalTo: true)
        
        let query = PFQuery.orQueryWithSubqueries([receiverQuery, intenderQuery])
        
        return query
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ConnectionsCell") as! ConnectionsTableViewCell!
        
        // Extract values from the PFObject to display in the table cell
        var name = ""
        var connectionId = ""
        if (object?["intenderId"] as? String == currentUserId) {
            name = (object?["receiverFullName"] as? String)!
            connectionId = (object?["receiverId"] as? String)!
        } else {
            name = (object?["intenderFullName"] as? String)!
            connectionId = (object?["intenderId"] as? String)!
        }
        cell?.connectionName?.text = name
        
        
        let initialThumbnail = UIImage(named: "ProfilePlaceholder")
        cell.profileImage.image = initialThumbnail

        let connectionQuery = PFUser.query()
        connectionQuery!.getObjectInBackgroundWithId(connectionId) { (connectionUser, error) -> Void in
            let dataQuery = PFQuery(className: "EmployeeData")
            dataQuery.getObjectInBackgroundWithId(connectionUser!["dataId"] as! String, block: { (data, error) -> Void in
                if let thumbnail = data!["profileImage"] as? PFFile {
                    cell.profileImage.file = thumbnail
                    cell.profileImage.loadInBackground()
                }
            })
            
            
        }
        
//        let connectionUser = PFQuery.getUserObjectWithId(connectionId)!
//        
//        if let thumbnail = connectionUser?["flag"] as? PFFile {
//            cell.profileImage.file = thumbnail
//            cell.profileImage.loadInBackground()
//        }
        
        return cell
    }
    
}


