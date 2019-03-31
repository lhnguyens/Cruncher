//
//  UploadViewController.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-19.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController {
    
    var capturedImageToUpload: UIImage?
    var username: String?
    var imageFileName: String?
    
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var capturedImagePreview: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCapturedImageToPreview()
        self.hideKeyboardWhenTappedAround()
    }
    
    func setCapturedImageToPreview () {
        if let image = capturedImageToUpload {
            capturedImagePreview.image = image
            print("yes")
        } else {
            print("fail")
            capturedImagePreview.image = UIImage(named: "steak")
        }
    }
    
    
    @IBAction func shareYourPosts(_ sender: UIButton) {
        uploadImageToStorageAndCreatePost()
    }
    
    
    func uploadImageToStorageAndCreatePost () {
        
        var idGenerator = SystemRandomNumberGenerator()
        let id = Int.random(in: 10000...99999, using: &idGenerator)
        imageFileName = String(id)
        
        let storage = Storage.storage()
        let storageRef = storage.reference().child("PhotosUploaded")
        let imagesRef = storageRef.child(imageFileName!)
        
        guard let image = capturedImageToUpload else {return}
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
        let uploadImage = imagesRef.putData(imageData, metadata: nil) { (query, error) in
            print("Uploaded Image Success")
            
            imagesRef.downloadURL { (url, error) in
                if let error = error {
                    print("Could not download URL \(error)")
                } else {
                    if let url = url {
                        let downloadURL = url.absoluteString
                        let db = Firestore.firestore().collection("posts")
                        let uploadingPost = Post(user: "Luan", description: "Test", likes: 1, imageURL: downloadURL)
                        db.addDocument(data: uploadingPost.toAny())
                        print("Posts added to firebase with url for image")
                        
                        self.dismiss(animated: true)
                        
                    }
                }
                
            }
            print(query ?? "No query")
            print(error ?? "No error")
        }
        uploadImage.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "No more progress")
        }
        uploadImage.resume()
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
