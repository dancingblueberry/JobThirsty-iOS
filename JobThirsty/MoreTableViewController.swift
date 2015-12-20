//
//  MoreTableViewController.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 12/19/15.
//  Copyright © 2015 Amanda Berryhill. All rights reserved.
//

import UIKit

class MoreTableViewController: UITableViewController {
    
    // MARK: - Table view data source
    struct moreTableCell {
        var label = ""
        var image = ""
        
    }
    let tableContents = [moreTableCell(label: "Profile",image: "Profile-25")]
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableContents.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MoreCell", forIndexPath: indexPath) as! MoreTableViewCell
        let rowContent = tableContents[indexPath.row]
        cell.label?.text = rowContent.label
        cell.moreImageView?.image = UIImage(named: rowContent.image)
        
        return cell
    }
    
}
