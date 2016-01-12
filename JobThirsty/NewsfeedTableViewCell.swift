//
//  NewsfeedTableViewCell.swift
//  JobThirsty
//
//  Created by Amanda Berryhill on 12/19/15.
//  Copyright © 2015 Amanda Berryhill. All rights reserved.
//

import UIKit
import ParseUI

class NewsfeedCollectionCell: PFCollectionViewCell {
    
    @IBOutlet weak var newsfeedProfileImage: PFImageView!
    @IBOutlet weak var nameLabel: UILabel!
}

class NewsfeedTableViewCell: PFTableViewCell {
    
    var newsfeedObject: PFObject!
    var involvedList: [String]!
    @IBOutlet weak var updateLabel: UILabel!
    @IBOutlet weak var collectionViewProfileImages: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return involvedList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> PFCollectionViewCell {
        
        let cell = collectionViewProfileImages.dequeueReusableCellWithReuseIdentifier("NewsfeedCollectionCell", forIndexPath: indexPath) as! NewsfeedCollectionCell
        
        let userId = involvedList[indexPath.row]
//        print ("\(newsfeedObject.objectId! as String): \(indexPath.row) -> \(userId)")
        getProfileImage(userId, profileImage: cell.newsfeedProfileImage, nameLabel: cell.nameLabel)
        return cell
    }
    
    func getProfileImage(userId:String, profileImage:PFImageView, nameLabel:UILabel) {
        
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
            nameLabel.text = (user!["firstName"] as! String) + " " + (user!["lastName"] as! String)
        }
        
    }
}
