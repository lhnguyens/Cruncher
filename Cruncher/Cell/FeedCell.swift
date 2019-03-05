//
//  FeedCell.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-05.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var userNameInFeedLabel: UILabel!
    

    
    func setName(feed: FeedModels) {
        userNameInFeedLabel.text = feed.username
    }
}
