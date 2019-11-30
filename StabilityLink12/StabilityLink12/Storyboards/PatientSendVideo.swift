//
//  PatientSendVideo.swift
//  StabilityLink12
//
//  Created by Daimon Gill on 2019-11-29.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
import FirebaseStorage
import MobileCoreServices
import AVFoundation
import Firebase
import FirebaseAuth


class PatientSendVideo: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var SelectVideo: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Mathew's Code for Video
        SelectVideo.setTitle("Select Video", for: .normal)
        
        
        // Opening Camera Roll for Selection
       
        
    }

    
    @IBAction func selectVideoPressed(_ sender: Any) {
        let imagecontroller = UIImagePickerController()
        imagecontroller.delegate = self
        imagecontroller.sourceType = UIImagePickerController.SourceType.photoLibrary
        //imagecontroller.mediaTypes = ["public.movie"]
        imagecontroller.mediaTypes = [kUTTypeMovie as String]
        imagecontroller.videoQuality = .typeHigh
        imagecontroller.allowsEditing = true
        present(imagecontroller, animated: true, completion: nil)
    }
    
    var imageReference: StorageReference {
        return Storage.storage().reference().child("videos")
    }
    
    // Send Button has been pressed
    @IBAction func SendButton(_ sender: Any) {
        // Push to firestore and storage
        
        // Segue back to previous view controller
        self.performSegue(withIdentifier: "BackToPatientHome", sender: nil)
    }
    
     
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        //print(info[.originalImage]!)
        if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL]  {
            print("Here is the file URL: ", videoUrl)
            let currentid = (Auth.auth().currentUser?.uid)!
            
            let storageRef = Storage.storage().reference().child("\(currentid)"+".mov")
            let videoData = NSData(contentsOf: videoUrl as! URL)
            //storageRef.putData(videoData as! Data)
            storageRef.putData(videoData! as Data, metadata: nil){
                (metadata,error) in
                if error != nil{
                    print("Failed upload of video:", error)
                    return
                }
                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print("download url has some problem")
                        return
                    }
                }
                
            }
            
        var selectedImageFromPicker : UIImage?
    
    
        self.dismiss(animated: true, completion: nil)
            
        
    }

}
    @IBAction func record(_ sender: Any) {
        VideoHelper.startMediaBrowser(delegate: self, sourceType: .camera)
    }
}

@objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
  let title = (error == nil) ? "Success" : "Error"
  let message = (error == nil) ? "Video was saved" : "Video failed to save"
  
  let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
  alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
  present(alert, animated: true, completion: nil)
}

// MARK: - UIImagePickerControllerDelegate

extension RecordVideoViewController: UIImagePickerControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    dismiss(animated: true, completion: nil)
    
    guard let mediaType = info[UIImagePickerControllerMediaType] as? String,
      mediaType == (kUTTypeMovie as String),
      let url = info[UIImagePickerControllerMediaURL] as? URL,
      UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
      else { return }
    
    // Handle a movie capture
    UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)
  }
  
}

// MARK: - UINavigationControllerDelegate

extension RecordVideoViewController: UINavigationControllerDelegate {
}

