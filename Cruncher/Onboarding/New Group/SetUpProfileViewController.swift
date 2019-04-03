//
//  SetUpProfileViewController.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-04-02.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//
import Foundation
import UIKit
import Firebase

class SetUpProfileViewController: UIViewController,  UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var profileDescription: UITextField!
    
    var imagePicker = UIImagePickerController()
    var userID: String!
    var db: Firestore!
    var storage: Storage!
    var imageName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        storage = Storage.storage()
        
        
    }
    
    func uploadUsername () {
        let ref = db.collection("users").document(userID)
        ref.updateData(["username": usernameField.text!])
        print("Username added")
        
    }
    
    func uploadProfileDescription() {
        let ref = db.collection("users").document(userID)
        ref.updateData(["profileDescription": profileDescription.text!])
    }
    
    func uploadProfileImage() {
        guard let image: UIImage = imageView.image else {return}
        imageName = UUID().uuidString
        let storageRef = storage.reference().child("ProfileImageFolder")
        let imageRef = storageRef.child(imageName!)
        
        let compressImage = image.jpegData(compressionQuality: 0.5)!
        let uploadImage = imageRef.putData(compressImage, metadata: nil) { (query, error) in
            print("Upload successful")
            
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    print("Could not download URL \(error)")
                } else {
                    let downloadURL = url?.absoluteString
                    print(downloadURL!)
                    let ref = self.db.collection("users").document(self.userID)
                    ref.updateData(["profilePicture": downloadURL!])
                    print("URL attached to the users document!")
                    self.dismiss(animated: true)
                    
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
    
    
    @IBAction func setupCompleteButton(_ sender: UIButton) {
        uploadUsername()
        uploadProfileDescription()
        uploadProfileImage()
    }
    
    @IBAction func tapToChooseProfileImage(_ sender: Any) {
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openCamera(UIImagePickerController.SourceType.camera)
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openCamera(UIImagePickerController.SourceType.photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }
        
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(_ sourceType: UIImagePickerController.SourceType) {
        imagePicker.sourceType = sourceType
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        print("Image chosen!")
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel choosing photo")
    }
    
    
}
