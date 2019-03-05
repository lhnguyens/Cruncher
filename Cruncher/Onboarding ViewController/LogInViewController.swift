//
//  LogInViewController.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-02-26.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import UIKit
import Lottie

class LogInViewController: UIViewController {
    
    @IBOutlet weak var loginAnimation: LOTAnimationView!
    @IBOutlet weak var loginView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
     
    }
    func startAnimation() {
        loginAnimation.setAnimation(named: "4675-a-guakka-loader-for-foodvisor")
        loginAnimation.loopAnimation = true
        loginAnimation.play(fromProgress: 0, toProgress: 0.2, withCompletion: nil)
    }
    


}


