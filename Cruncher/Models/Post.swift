//
//  Post.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-22.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import Foundation
import UIKit

class Post {
    var user: String?
    var description: String?
    var likes: Int?
    var imageURL: String?
    
    init(user: String, description: String, likes: Int, imageURL: String) {
        self.user = user
        self.description = description
        self.likes = likes
        self.imageURL = imageURL
    }
    
    func toAny() -> [String: Any] {
        
        return ["user": user!,
                "description": description!,
                "likes": likes!,
                "imageURL": imageURL!
        ]
    }
}
