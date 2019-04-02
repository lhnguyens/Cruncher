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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
    }
    
     func signUpUser () {
        let auth = Auth.auth()
        auth.createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (authResult, error) in
            if let error = error {
                print("Sign up Error: \(error)")
                
                self.showNotification(title: "Sign up failed, try a valid email or a password with more than 6 charachters!", message: "Please Try Again Scrub")
                
                
            } else {
                print("\(String(describing: authResult?.user.email!)) created")
                self.performSegue(withIdentifier: "goToSetup", sender: self)
            }
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        signUpUser()
    }
    
    

    
}

extension UIViewController {
    
    func showNotification(title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}

