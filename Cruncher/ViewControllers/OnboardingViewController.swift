//
//  OnboardingViewController.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-02-25.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import UIKit
import Lottie

class OnboardingViewController: UIViewController {
    @IBOutlet weak var animationView: LOTAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    startAnimation()
    }
    
    func startAnimation() {
        
        animationView.setAnimation(named: "32-camera")
        animationView.loopAnimation = true
        animationView.play()
        
    }
    


}
