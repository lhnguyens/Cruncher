//
//  User.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-22.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class User {
    var email: String?
    var profilePicture: String?
    var profileDescription: String?
    var username: String?
    var posts: [Post]?
    var userID: String?
   
    
    init(email: String, profilePicture: String, profileDescription: String, username: String, posts:[Post]) {
        self.email = email
        self.profilePicture = profilePicture
        self.profileDescription = profileDescription
        self.username = username
        self.posts = posts
        self.userID = ""
        

    }
    
    func toAny() -> [String: Any] {
        
        return ["email": email!,
                "profilePicture": profilePicture!,
                "profileDescription": profileDescription!,
                "username": username!,
                "posts": posts!
        ]
    }

}
