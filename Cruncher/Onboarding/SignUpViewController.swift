//
//  SignUpViewController.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-02-26.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    var ref: DocumentReference? = nil
    var userIDToSegue: String?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    func signUpUser () {
        let auth = Auth.auth()
        auth.createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (authResult, error) in
            if let error = error {
                print("Sign up Error: \(error)")
                self.showNotification(title: "Sign up failed, try a valid email or a password with more than 6 charachters!", message: "Please Try Again")
            } else {
                print("\(String(describing: authResult?.user.email!)) created")
                let db = Firestore.firestore().collection("users")
                let data: User = User(email: self.emailTextfield.text!, profilePicture: "", profileDescription: "", username: "", posts:[])
                self.ref = db.addDocument(data: data.toAny()) { err in
                    if let err = err {
                        print("Error trying to create document \(err)")
                    } else {
                        data.userID = self.ref?.documentID
                        let convertedID = String(data.userID!)
                        self.userIDToSegue = convertedID
                        let docs = Firestore.firestore().collection("users").document(convertedID)
                        docs.updateData(["ID": convertedID])
                        print("Account created and user is connected to database. UUID is: \(convertedID)")
                        self.performSegue(withIdentifier: "goToSetup", sender: self)
                    }
                }
            }
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        signUpUser()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSetup" {
            let vc = segue.destination  as! SetUpProfileViewController
            vc.userID = userIDToSegue
        }
    }
}

extension UIViewController {
    
    func showNotification(title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK Sir", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}

