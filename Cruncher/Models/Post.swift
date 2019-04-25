//
//  Post.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-22.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Post {
    var user: String?
    var description: String?
    var likes: Int?
    var imageURL: String?
    var postUserID: String?
    var createdAt: Date?
    var profileImage: String?
    var checked: Bool = false

    
    
    
    
    init(user: String, description: String, likes: Int, imageURL: String, postUserID: String, date: Date, profileImage: String) {
        
        self.user = user
        self.description = description
        self.likes = likes
        self.imageURL = imageURL
        self.postUserID = postUserID
        self.createdAt = date //Date(timeIntervalSince1970: timestamp/1000)
        self.profileImage = profileImage
        
    }
    
    func toAny() -> [String: Any] {
        
        return ["user": user!,
                "description": description!,
                "likes": likes!,
                "imageURL": imageURL!,
                "postUserID": postUserID!,
                "timestamp": createdAt!,
                "profileImage": profileImage!
        ]
    }
    
    
}
