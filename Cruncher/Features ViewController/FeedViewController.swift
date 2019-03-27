//
//  FeedViewController.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-05.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import UIKit

import Firebase

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //    var feed: [FeedModels] = []
    
    var postsData: [Post] = []
    var postListener: ListenerRegistration?
    
    //Sample Array that contains the uploaded data to firebase
    var samplePostsUploaded = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        feed = createArrayForFeed()
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        findPosts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopListeningForPosts()
    }
    
    //    func createArrayForFeed() -> [FeedModels] {
    //
    //        let user1 = FeedModels(username: "Emma", descriptionLabel: "Best salmon bowl!", pictureName: "SalmonDish", profilePicture: "ProfilePictureUser1"   )
    //        let user2 = FeedModels(username: "Travis", descriptionLabel: "After a long day, I need this!", pictureName: "burger", profilePicture: "user2profilepic")
    //        let user3 = FeedModels(username: "Drake", descriptionLabel: "Yummy", pictureName: "pizza", profilePicture: "user3profilepic")
    //        let user4 = FeedModels(username: "June", descriptionLabel: "#HEALTHY", pictureName: "steak", profilePicture: "user4profilepic")
    //
    //        return [user1, user2, user3, user4]
    //
    //    }
    
    func populateSamplePosts() {
        let sampleUserOne = Post(user: "sampleUserOne", description: "Test 1", likes: 1)
        let sampleUserTwo = Post(user: "sampleUserTwo", description: "Test 2", likes: 2)
        let sampleUserThree = Post(user: "sampleUserThree", description: "Test 3", likes: 3)
        let sampleUserFour = Post(user: "sampleUserFour", description: "Test 4", likes: 4)
        let sampleUserFive = Post(user: "sampleUserFive", description: "Test 5", likes: 5)
        let sampleUserSix = Post(user: "sampleUserSix", description: "Test 6", likes: 6)
        let sampleUserSeven = Post(user: "sampleUserSeven", description: "Test 7", likes: 7)
        let sampleUserEight = Post(user: "sampleUserEight", description: "Test 8", likes: 8)
        
        for item in samplePostsUploaded {
            
        }
        
    }
    
    func findPosts() {
        let db = Firestore.firestore().collection("posts").limit(to: 20)
       postListener = db.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error when trying to load posts: \(error)")
            } else {
                if let querySnapshot = querySnapshot {
                    for document in querySnapshot.documents {
                        let data = document.data()
                        let user = data["user"] as? String ?? ""
                        let description = data["description"] as? String ?? ""
                        let likes = data["likes"] as? Int ?? 0
                        let newPosts = Post(user: user, description: description, likes: likes)
                        self.postsData.append(newPosts)
                    }
                }
                 self.tableView.reloadData()
            }
        }
        
    }
    func stopListeningForPosts() {
        postListener?.remove()
        postListener = nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  postsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        let feeds = feed[indexPath.row]
        //
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        //
        //        cell.setName(feed: feeds)
        //        return cell
        
    
        let newPosts = postsData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        cell.populatePosts(post: newPosts)
        return cell
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
    
}
