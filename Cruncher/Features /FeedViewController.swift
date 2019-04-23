//
//  FeedViewController.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-05.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import UIKit

import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var indexPathForLike: Post?
    
    //array that holds the value for posts uploaded for tableview to retrieve from.
    var postsData: [Post] = []
    var postListener: ListenerRegistration?
    //Sample Array that contains the uploaded data to firebase
    var samplePostsUploaded = [Post]()
    
    var testData: String!
    var auth: Auth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        populateSamplePosts()
        auth = Auth.auth()
        if let authorizedAuth =  auth.currentUser?.uid {
            print(authorizedAuth)
        }
        else {
            print("No current users")
        }
       
        tableView.dataSource = self
        tableView.delegate = self
       
        


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        findPosts()
        print("Finding Posts to show in feed")
        print(testData)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear (animated)
        stopListeningForPosts   ()
        print                   ("Cancel finding post")
    }
    
    
    func findPosts() {
        let db = Firestore.firestore().collection("posts").limit(to: 50)
        postListener = db.order(by:"timestamp", descending: true).addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error when trying to load posts: \(error)")
            } else {
             
               self.postsData.removeAll()
                if let querySnapshot = querySnapshot {
                    for document in querySnapshot.documents {
                        let data = document.data()
                        let user = data["user"] as? String ?? ""
                        let description = data["description"] as? String ?? ""
                        let likes = data["likes"] as? Int ?? 0
                        let imageURL = data["imageURL"] as? String ?? ""
                        let postID = data["postUserID"] as? String ?? ""
                        guard let timestamp = data["timestamp"] as? Timestamp else {return}
                        let date = timestamp.dateValue()
                        let newPosts = Post(user: user, description: description, likes: likes, imageURL: imageURL, postUserID: postID, date: date)
                        self.postsData.append(newPosts)
                    }
                }
                self.tableView.reloadData()
                print("Tableview has obtained the data")
            }
        }
        
    }
    func stopListeningForPosts() {
        postListener?.remove()
        postListener = nil
        print("stop listening")
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  postsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let newPosts = postsData[indexPath.row]
        indexPathForLike = postsData[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        cell.populatePosts(post: newPosts)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
    
}

