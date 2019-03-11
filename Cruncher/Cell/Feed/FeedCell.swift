//
//  FeedCell.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-05.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var userNameInFeedLabel: UILabel!
    @IBOutlet weak var profileImageViewInFeed: UIImageView!
    @IBOutlet weak var userUploadImageView: UIImageView!
    @IBOutlet weak var descriptionBox: UILabel!
    

    
    func setName(feed: FeedModels) {
        userNameInFeedLabel.text = feed.username
        descriptionBox.text = feed.descriptionLabel
        userUploadImageView.image = UIImage(named: feed.pictureName )
        profileImageViewInFeed.image = UIImage(named: feed.profilePicture)
        
    }
}
