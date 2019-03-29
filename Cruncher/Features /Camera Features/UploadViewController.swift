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
    
    
    
    
    @IBOutlet weak var capturedImagePreview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCapturedImageToPreview()
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
        
        var idGenerator = SystemRandomNumberGenerator()
        let id = Int.random(in: 10000...99999, using: &idGenerator)
        let storageChild = String(id)
        
        let storage = Storage.storage()
        let storageRef = storage.reference().child("PhotosUploaded")
        let imagesRef = storageRef.child(storageChild)
        guard let image = capturedImageToUpload else {return}
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
        let uploadImage = imagesRef.putData(imageData, metadata: nil) { (query, error) in
            print("Uploaded Image Success")
            print(query ?? "No query")
            print(error ?? "No error")
        }
        uploadImage.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "No more progress")
            
        }
        uploadImage.resume()
        dismiss(animated: true, completion:nil)
        
    }
    
    
    
}
