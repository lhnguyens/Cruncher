//
//  OnboardingViewController.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-02-25.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import UIKit
import Lottie
import Firebase

class OnboardingViewController: UIViewController {
    @IBOutlet weak var animationView: AnimationView!
    let animation = Animation.named("32-camera")
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startAnimation()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let auth = Auth.auth()

        if let user = auth.currentUser {
            performSegue(withIdentifier: "goDirectToApp", sender: user)
            } else {
            print("No current user")
        }

    
    }
    
    func startAnimation() {
        animationView.animation = animation
        animationView.loopMode = .loop
        animationView.play()
        
    }
    


}
