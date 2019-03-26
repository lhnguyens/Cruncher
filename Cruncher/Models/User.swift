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
    var name: String
    var profilePicture: URL?
    var profileDescription: String?
    var username: String
    var userID: String
    var posts: [Post] = []
    
    
    
    init(name: String, profilePicture: URL?, profileDescription: String, username: String, userID: String, posts:[Post]) {
        self.name = name
        self.profilePicture = profilePicture
        self.profileDescription = profileDescription
        self.username = username
        self.userID = userID
        self.posts = posts
    }

}
