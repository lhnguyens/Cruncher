//
//  ProfileCollectionCell.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-08.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import Foundation
import UIKit

class ProfileCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageInCollection: UIImageView!
    
    
    func setImageInProfileFeed(image: ProfileModels) {
        profileImageInCollection.image = UIImage(named: image.uploadedImageInProfileFeed)
    }
}
