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
    
    var currentUserId:String!
    
    @IBOutlet weak var connectionsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableHeaderView: UIView!
    
    override func viewDidAppear(animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.tableHeaderView = self.tableHeaderView
//        self.tableView.contentOffset = CGPointMake(0, self.searchDisplayController.searchBar.frame.size.height);
        self.tableView.contentOffset = CGPointMake(0, self.tableHeaderView.frame.size.height)
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
        self.parseClassName = "Connections"
        self.textKey = "name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 20
        
        self.currentUserId = PFUser.currentUser()?.objectId
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        
        var query:PFQuery!
        
        if (connectionsSegmentedControl.selectedSegmentIndex == 0) {
            let receiverQuery = PFQuery(className: parseClassName!)
            receiverQuery.whereKey("receiverId", equalTo: currentUserId)
            receiverQuery.whereKey("handshake", equalTo: true)
            
            let intenderQuery = PFQuery(className: parseClassName!)
            intenderQuery.whereKey("intenderId", equalTo: currentUserId)
            intenderQuery.whereKey("handshake", equalTo: true)
            
            query = PFQuery.orQueryWithSubqueries([receiverQuery, intenderQuery])
        } else {
            query = PFQuery(className: parseClassName!)
            query.whereKey("receiverId", equalTo: currentUserId)
            query.whereKey("handshake", equalTo: false)
        }
        
        return query
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        let cellIdentifier = (connectionsSegmentedControl.selectedSegmentIndex == 0) ? "ConnectionsCell" : "ConnectionsRequestCell"
        var cell:ConnectionsTableViewCell!
        
        cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! ConnectionsTableViewCell!
        
        // Extract values from the PFObject to display in the table cell
        var name = ""
        var connectionId = ""
        
        cell.tableView = self
        cell.connectionObject = object
        
        if (object?["intenderId"] as? String == currentUserId) {
            name = (object?["receiverFullName"] as? String)!
            connectionId = (object?["receiverId"] as? String)!
        } else {
            name = (object?["intenderFullName"] as? String)!
            connectionId = (object?["intenderId"] as? String)!
        }
        cell.connectionName?.text = name
        
        getProfileImage(connectionId, profileImage: cell.profileImage)
        
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
    
    @IBAction func connectionsSegmentedControlValueChanged(sender: AnyObject) {
        
        self.loadObjects()
    }
}


