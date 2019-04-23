//
//  FeedCell.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-05.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class FeedCell: UITableViewCell {

    @IBOutlet weak var userNameInFeedLabel: UILabel!
    @IBOutlet weak var profileImageViewInFeed: UIImageView!
    @IBOutlet weak var userUploadImageView: UIImageView!
    @IBOutlet weak var descriptionBox: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    
    var urlForProfilePicture: String?
    
    
    
    func populatePosts(post: Post) {
        findUserProfileImage()
        userNameInFeedLabel.text = post.user
        descriptionBox.text = post.description
        userUploadImageView.sd_setImage(with: URL(string: post.imageURL!), placeholderImage: UIImage(named: "StorageTestImage"))
        guard let urlFound = urlForProfilePicture else {return}
        profileImageViewInFeed.sd_setImage(with: URL(string: urlFound), placeholderImage: UIImage(named: "StorageTestImage"))
        likesLabel.text = String(post.likes!)
        createdAtLabel.text = post.createdAt!.calenderTimeSinceNow()
    }
    
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        likeButton.isSelected = !likeButton.isSelected
    }

    func findUserProfileImage() {
        let auth = Auth.auth().currentUser?.uid
        let db = Firestore.firestore().collection("users").document(auth!)
        db.getDocument() { (query, error) in
            if let error = error {
                print("Error fetching user profile picture: \(error)")
            } else {
                let data = query?.data()
                let url = data!["profilePicture"] as? String ?? ""
                self.urlForProfilePicture = url
            }

        }
    }

  
}
