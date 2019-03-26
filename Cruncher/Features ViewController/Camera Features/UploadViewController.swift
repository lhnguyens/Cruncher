//
//  UploadViewController.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-19.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import UIKit

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
    

   

}
