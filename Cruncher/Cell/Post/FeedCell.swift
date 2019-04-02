//
//  FeedCell.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-05.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import UIKit
import SDWebImage

class FeedCell: UITableViewCell {

    @IBOutlet weak var userNameInFeedLabel: UILabel!
    @IBOutlet weak var profileImageViewInFeed: UIImageView!
    @IBOutlet weak var userUploadImageView: UIImageView!
    @IBOutlet weak var descriptionBox: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    
    
    func populatePosts(post: Post) {
        userNameInFeedLabel.text = post.user
        descriptionBox.text = post.description
        userUploadImageView.sd_setImage(with: URL(string: post.imageURL!), placeholderImage: UIImage(named: "StorageTestImage"))
        profileImageViewInFeed.image = UIImage(named: "user3profilepic")
        likesLabel.text = String(post.likes!)
    }
    
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        likeButton.isSelected = !likeButton.isSelected
    }
    

  
}
