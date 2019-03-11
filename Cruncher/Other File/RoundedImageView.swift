//
//  RoundedImageView.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-07.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import Foundation
import UIKit


class RoundedImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = self.frame.width/2.0
        layer.cornerRadius = radius
       
    }
    
}
