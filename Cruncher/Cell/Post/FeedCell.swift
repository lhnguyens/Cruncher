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
    
    
//    var urlForProfileImage : String?
    
    func populatePosts(post: Post) {
        userNameInFeedLabel.text = post.user
        descriptionBox.text = post.description
        likesLabel.text = String(post.likes!)
        createdAtLabel.text = post.createdAt!.calenderTimeSinceNow()
        userUploadImageView.sd_setImage(with: URL(string: post.imageURL!), placeholderImage: UIImage(named: "StorageTestImage"))
//        guard let urlFound = urlForProfileImage else {return}
        profileImageViewInFeed.sd_setImage(with: URL(string: post.profileImage!), placeholderImage: UIImage(named: "StorageTestImage"))
    }
    
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        likeButton.isSelected = !likeButton.isSelected
    }
    
//    func fetchingProfilePicture () {
//        let db = Firestore.firestore().collection("posts").whereField("profileImage", isEqualTo: true)
//        db.getDocuments() { (querySnapshot, error) in
//            if let error = error {
//                print("Error: FeedCell \(error)")
//            } else
//            {
//                if let query = querySnapshot {
//                    for docs in query.documents {
//                        let data = docs.data()
//                        let urlForProfile = data["profileImage"] as? String ?? ""
//                        self.urlForProfileImage = urlForProfile
//                        print("fetch successful")
//                    }
//                }
//            }
//
//        }
//    }
    
    
   
}
