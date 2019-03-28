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
    @IBOutlet weak var animationView: AnimationView!
    let animation = Animation.named("32-camera")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    startAnimation()
        
    }
    
    func startAnimation() {
        animationView.animation = animation
        animationView.loopMode = .loop
        animationView.play()
        
    }
    


}
