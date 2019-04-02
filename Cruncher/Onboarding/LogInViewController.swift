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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
     
    }
    func startAnimation() {
        loginAnimation.animation = animation
        loginAnimation.loopMode = .loop
        loginAnimation.play()
    }
    


}


