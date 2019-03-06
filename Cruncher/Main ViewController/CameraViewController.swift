//
//  CameraViewController.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-06.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    @IBOutlet weak var photoPreviewImageView: UIImageView!
    
    var session: AVCaptureSession?
    var stillImageOutput: AVCaptureOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSession.Preset.photo
        
        let backCamera = AVCaptureDevice.defaultDEf
        
      
    }
    

    @IBAction func didTapOnToTakePhoto(_ sender: Any) {
        
    
    }
    
}
