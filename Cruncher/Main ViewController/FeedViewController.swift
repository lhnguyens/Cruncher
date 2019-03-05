//
//  FeedViewController.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-05.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var feed: [FeedModels] = []
    
 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        feed = createArrayForFeed()
        
        
        tableView.dataSource = self
        tableView.delegate = self

       
    }
    
    func createArrayForFeed() -> [FeedModels] {
        
        let user1 = FeedModels(username: "Luke")
        let user2 = FeedModels(username: "Travis")
        let user3 = FeedModels(username: "Drake")
        let user4 = FeedModels(username: "Eminiem")
        
        return [user1, user2, user3, user4]
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let feeds = feed[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        
        cell.setName(feed: feeds)
        return cell
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    

    
}
