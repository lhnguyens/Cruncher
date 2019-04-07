//
//  LogInViewController.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-02-26.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import UIKit
import Lottie
import Firebase

class LogInViewController: UIViewController {
    
    @IBOutlet weak var loginAnimation: AnimationView!
    @IBOutlet weak var loginView: UIView!
    let animation = Animation.named("4675-a-guakka-loader-for-foodvisor")
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    var auth: Auth!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
        auth = Auth.auth()
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
     
    }
    func startAnimation() {
        loginAnimation.animation = animation
        loginAnimation.loopMode = .loop
        loginAnimation.play()
    }
    
    func signInUser () {
        auth.signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { ( user, error) in
            if let error = error {
                print("Failed Logged in, try again! \(error)")
            }
            else {
                guard let currentUser = user else {return}
                print("Login succesfully: \(currentUser)")
                self.performSegue(withIdentifier: "loginSuccessSegue", sender: self)
            }
            
        }
    }
    
    @IBAction func signInButton(_ sender: Any) {
        signInUser()
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y -= 150
    }
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 150
    }
    

}


