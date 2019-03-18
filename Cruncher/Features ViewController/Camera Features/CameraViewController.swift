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
    
    @IBOutlet weak var capturePreviewView: UIView!
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var capturePhotoOutput: AVCapturePhotoOutput?
    
    override func viewDidLoad() {
        
        if #available(iOS 10.2, *)
        {
            
            let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice!)
                captureSession = AVCaptureSession()
                captureSession?.addInput(input)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                videoPreviewLayer?.frame = view.layer.bounds
                capturePreviewView.layer.addSublayer(videoPreviewLayer!)
                captureSession?.startRunning()
            }
            catch {
                print("Error: Cannot Load Camera")
            }
        }
        capturePhotoOutput = AVCapturePhotoOutput()
        capturePhotoOutput?.isHighResolutionCaptureEnabled = true
        captureSession?.addOutput(capturePhotoOutput!)
        
        
    }
    
    @IBAction func captureImage(_ sender: Any) {
        guard let capturePhotoOutput = self.capturePhotoOutput else { return
        }
        let photoSetting = AVCapturePhotoSettings()
        photoSetting.isAutoStillImageStabilizationEnabled = true
        photoSetting.isHighResolutionPhotoEnabled = true
        capturePhotoOutput.capturePhoto(with: photoSetting, delegate: self)
    }
    
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings backetSetting: AVCaptureBracketedStillImageSettings?, error: Error?) {
        guard error == nil,
            let photoSampleBuffer = photoSampleBuffer  else {
                print("error")
                return
        }
        guard let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer) else {
            return
        }
        let capturedImage = UIImage.init(data: imageData, scale: 1.0)
        if let image = capturedImage {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
}
