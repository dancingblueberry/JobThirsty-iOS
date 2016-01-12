//
//  PositionTableViewController.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 1/10/16.
//  Copyright © 2016 Amanda Berryhill. All rights reserved.
//

import ParseUI
import UIKit

class PositionTableViewController: PFQueryTableViewController {
    
    var currentUserId:String!
    
    @IBOutlet weak var positionsSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
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
        
        // Get the new view controller using [segue destinationViewController].
        if (segue.identifier == "BrowseToDetail" || segue.identifier == "AppliedToDetail") {
            
            let detailScene = segue.destinationViewController as! PositionDetailTableViewController
            
            // Pass the selected object to the destination view controller.
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let row = Int(indexPath.row)
                detailScene.positionObject = (objects![row] )
                detailScene.fromSegueId = segue.identifier
            }
        }
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
        
        var query: PFQuery!
        
        // browsing (positions i haven't applied for)
        if (positionsSegmentedControl.selectedSegmentIndex == 0) {
            query = PFQuery(className: parseClassName!)
            query.whereKey("appliedArray", notEqualTo: currentUserId)
        }
        // viewing applied (positions i've applied for)
        else if (positionsSegmentedControl.selectedSegmentIndex == 1) {
            query = PFQuery(className: "AppliedWorkers")
            query.whereKey("applicantId", equalTo: currentUserId)
        }
        // viewing posted (positions i've posted)
        else {
            query = PFQuery(className: parseClassName!)
            query.whereKey("bossId", equalTo: currentUserId)
        }
        
        return query
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        //        let cellIdentifier = "PositionCell"
        var cellIdentifier: String!
        if (positionsSegmentedControl.selectedSegmentIndex == 0) {
            cellIdentifier = "PositionCell"
        } else if (positionsSegmentedControl.selectedSegmentIndex == 1) {
            cellIdentifier = "AppliedCell"
        } else {
            cellIdentifier = "PostedCell"
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! PositionTableViewCell!
        
        // Extract values from the PFObject to display in the table cell
        cell.positionObject = object
        cell.positionsSegmentedControl = self.positionsSegmentedControl
        
        if (positionsSegmentedControl.selectedSegmentIndex == 0 ||
            positionsSegmentedControl.selectedSegmentIndex == 2) {
                
                if let name = object?["positionTitle"] as? String {
                    cell?.positionTitleLabel?.text = name
                }
                
                if let companyTitle = object?["companyTitle"] as? String {
                    cell?.companyTitleLabel?.text = companyTitle
                }
                
                if let location = object?["location"] as? String {
                    cell?.locationLabel?.text = location
                }
        } else {
            
            if let name = object?["position"] as? String {
                cell?.positionTitleLabel?.text = name
            }
            
            //            if let companyTitle = object?["companyTitle"] as? String {
            //                cell?.companyTitleLabel?.text = companyTitle
            //            }
            
            if let location = object?["location"] as? String {
                cell?.locationLabel?.text = location
            }
        }
        
        return cell
    }
    
    @IBAction func connectionsSegmentedControlValueChanged(sender: AnyObject) {
        
        self.loadObjects()
    }
    
    @IBAction func cancelToPositionsViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func pressButtonPositionAdd(sender: AnyObject) {
        
//        let selectedRow = tableView.indexPathForSelectedRow
//        self.editing = true
//        self.objects?.removeAtIndex(selectedRow)
//        tableView.deleteRowsAtIndexPaths([selectedRow!], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    @IBAction func postNewPosition(segue:UIStoryboardSegue) {
//        print("<POST POSITION>")
        if segue.identifier == "PostNewPosition" {
            if let positionEditTableViewController = segue.sourceViewController as? PositionEditTableViewController {
                let positionTitle = positionEditTableViewController.positionTitleTextField.text
                let companyTitle = positionEditTableViewController.companyTitleTextField.text
                let location = positionEditTableViewController.locationTextField.text
                let description = positionEditTableViewController.descriptionTextView.text
                
//                print("position: \(positionTitle)")
//                print("companyTitle: \(companyTitle)")
//                print("location: \(location)")
//                print("description: \(description)")
                
                let newPosition = PFObject(className: "Position")
                newPosition["bossId"] = currentUserId
                newPosition["positionTitle"] = positionTitle
                newPosition["companyTitle"] = companyTitle
                newPosition["location"] = location
                newPosition["description"] = description
                newPosition.saveInBackground()
            }
        }
    }
    
}
