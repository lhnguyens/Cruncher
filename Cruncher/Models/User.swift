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
    var profilePicture: String?
    var profileDescription: String?
    var username: String
    
    var posts: [Post] = []
    
    init(name: String, profilePicture: String, profileDescription: String, username: String, posts:[Post]) {
        self.name = name
        self.profilePicture = profilePicture
        self.profileDescription = profileDescription
        self.username = username
        self.posts = posts
    }

}
