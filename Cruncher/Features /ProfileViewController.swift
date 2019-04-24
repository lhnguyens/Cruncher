//
//  ProfileViewController.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-07.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profileImage: RoundedImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileBio: UILabel!
    
    
//    var profileFeed = [ProfileModels]()
    var db: Firestore!
    var auth: Auth!
    var arrayForUrl = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        auth = Auth.auth()
        db = Firestore.firestore()
       
        fetchProfileImageAndSetIt()
        fetchProfileDescription()
        fetchUsername()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        findUserPostImages()
    }
   
    
    func fetchProfileImageAndSetIt () {
        //Fetch url
        
        guard let userID = auth.currentUser?.uid else {return}
        let query = db.collection("users").document(userID)
        query.addSnapshotListener { (document, error) in
            if let error = error {
                print("Error fetching profile url \(error)")
            } else {
                let documentFetched = document?.data()?["profilePicture"] as! String
                self.profileImage.sd_setImage(with: URL(string: documentFetched), placeholderImage: UIImage(named: "burger"))
            }
            
        }
    }
    
    func fetchProfileDescription () {
        let userID = auth.currentUser?.uid
        let query = db.collection("users").document(userID!)
        query.addSnapshotListener { (document, error) in
            if let error = error {
                print("There was an error fetching the profile description: \(error)")
            } else {
                let document = document?.data()?["profileDescription"] as! String
                let pfDescription = document
                self.profileBio.text = pfDescription
            }
            
        }
    }
    
    func fetchUsername () {
        guard let userID = auth.currentUser?.uid else {return}
        let query = db.collection("users").document(userID)
        query.addSnapshotListener  { (document, error) in
            if let error = error {
                print("There was an error fetching the profile description: \(error)")
            } else {
                let document = document?.data()?["username"] as! String
                let username = document
                self.usernameLabel.text = username
            }
            
        }
    }
    @IBAction func signingOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
            
        catch let signOutError as NSError {
            
            print("There was an error signing out \(signOutError)")
            
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let startVC = storyboard.instantiateViewController(withIdentifier: "StartVC")
        self.present(startVC, animated: true, completion: nil)
    }
    
    func findUserPostImages () {
        guard let userID = auth.currentUser?.uid else {return}
        let query = db.collection("posts").whereField("postUserID", isEqualTo: userID)
        query.order(by:"timestamp", descending: true).addSnapshotListener() { (query, error) in
            if let error = error {
                print("Error profile: \(error)")
            } else {
                if let query = query {
                    self.arrayForUrl.removeAll()
                    for docs in query.documents {
                        let data = docs.data()
                        let url = data["imageURL"] as? String ?? ""
                        print(url)
                        self.arrayForUrl.append(url)
                        
                    }
                }
                self.collectionView.reloadData()
            }
        }
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayForUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCollectionCell", for: indexPath) as! ProfileCollectionCell
        cell.profileImageInCollection.sd_setImage(with: URL(string: arrayForUrl[indexPath.row]), placeholderImage: UIImage(named: "steak"))
        return cell
        
    }
}
