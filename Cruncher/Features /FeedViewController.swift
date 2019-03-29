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
    
    //array that holds the value for posts uploaded for tableview to retrieve from.
    var postsData: [Post] = []
    var postListener: ListenerRegistration?
    //Sample Array that contains the uploaded data to firebase
    var samplePostsUploaded = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        populateSamplePosts()
        tableView.dataSource = self
        tableView.delegate = self
        
        sampleReadDocumentId()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        findPosts()
        print("Finding Posts to show in feed")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear (animated)
        stopListeningForPosts   ()
        print                   ("Cancel finding post")
    }
    
    func populateSamplePosts() {
        
        let db = Firestore.firestore().collection("posts")
        
        let sampleUserOne =     Post(user: "sampleUserOne", description: "Test 1", likes: 1)
        let sampleUserTwo =     Post(user: "sampleUserTwo", description: "Test 2", likes: 2)
        let sampleUserThree =   Post(user: "sampleUserThree", description: "Test 3", likes: 3)
        let sampleUserFour =    Post(user: "sampleUserFour", description: "Test 4", likes: 4)
        let sampleUserFive =    Post(user: "sampleUserFive", description: "Test 5", likes: 5)
        let sampleUserSix =     Post(user: "sampleUserSix", description: "Test 6", likes: 6)
        let sampleUserSeven =   Post(user: "sampleUserSeven", description: "Test 7", likes: 7)
        let sampleUserEight =   Post(user: "sampleUserEight", description: "Test 8", likes: 8)
        let sampleUserNine =    Post(user: "sampleUserNine", description: "Test 9", likes: 9)
        let sampleUserTen =     Post(user: "sampleUserTen", description: "Test 10", likes: 10)
        
        samplePostsUploaded.append(sampleUserOne)
        samplePostsUploaded.append(sampleUserTwo)
        samplePostsUploaded.append(sampleUserThree)
        samplePostsUploaded.append(sampleUserFour)
        samplePostsUploaded.append(sampleUserFive)
        samplePostsUploaded.append(sampleUserSix)
        samplePostsUploaded.append(sampleUserSeven)
        samplePostsUploaded.append(sampleUserEight)
        samplePostsUploaded.append(sampleUserNine)
        samplePostsUploaded.append(sampleUserTen)
        
        for item in samplePostsUploaded  {
            db.addDocument(data: item.toAny())
        }
    }
    
    func sampleReadDocumentId() {
        let baseQuery = Firestore.firestore().collection("posts").limit(to: 3).whereField("likes", isEqualTo: 7)
        baseQuery.getDocuments() { (snapShot, error) in
            
            if let error = error {
                print("\(error)")
            } else {
                guard let snapShot = snapShot else { return }
                for documents in snapShot.documents {
                    print("Successfully retreived document id for: \(documents.documentID)")
                }
            }
            
        }
    }
    
    func findPosts() {
        let db = Firestore.firestore().collection("posts").limit(to: 3).whereField("likes", isEqualTo: 7)
        postListener = db.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error when trying to load posts: \(error)")
            } else {
                
                //Clear the array before calling method again when going back into the view in order to avoid duplicates of data.
               self.postsData.removeAll()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        cell.populatePosts(post: newPosts)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
    
}
