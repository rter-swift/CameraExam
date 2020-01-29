//
//  ViewController.swift
//  CameraExam
//
//  Created by seunghoon on 21/01/2020.
//  Copyright © 2020 MumunInc. All rights reserved.
//

import UIKit
import MobileCoreServices
import Photos

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    
    var captureImage: UIImage!
    var flagImageSave = false
    
    let dialog = UIAlertController(title: "주의", message: "일부 기능이 동작하지 않습니다. [설정] 에서 허용할 수 있습니다.", preferredStyle: .alert)
    let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
    
    
    
    @IBOutlet var dummyImageView: UIImageView!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.imagePicker(picker,nil)
        }
    }
        
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dialog.addAction(action)
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            
            if response {
                
            } else {
                self.present(self.dialog, animated: true, completion: nil)
            }
        }
        
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            
            PHPhotoLibrary.requestAuthorization({ (status:PHAuthorizationStatus) -> Void in
                if status != .authorized {
                    self.present(self.dialog, animated: true, completion: nil)
                }
            })
            
        }
    }

    @IBAction func captureImage(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            
        }
    }
    @IBAction func getAlbum(_ sender: Any) {
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        } else {
            
            
            
        }
                
      

    }
    
}

