//
//  FeedModels.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-05.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import Foundation

class FeedModels {
    
    var username: String
    var descriptionLabel: String
    var pictureName: String
    var profilePicture: String
    
    init(username: String, descriptionLabel: String, pictureName: String, profilePicture: String) {
        self.username = username
        self.descriptionLabel = descriptionLabel
        self.pictureName = pictureName
        self.profilePicture = profilePicture
    }
}
