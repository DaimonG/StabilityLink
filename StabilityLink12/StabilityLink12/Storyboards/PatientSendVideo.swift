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
    var videoAndImageReview = UIImagePickerController()
    var videoURL : URL?
    var flag = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Mathew's Code for Video
        SelectVideo.setTitle("Select Video", for: .normal)
        
        
        // Opening Camera Roll for Selection
       
        
    }
    // take video function when recordvideobutton pressed
    
    @IBAction func recordvideo(_ sender: Any) {
        flag = true
        let mediaUI = UIImagePickerController()
           mediaUI.mediaTypes = [kUTTypeMovie as String]
           mediaUI.sourceType = .camera
           mediaUI.videoQuality = .typeHigh
           mediaUI.allowsEditing = true
           mediaUI.delegate = self
           self.present(mediaUI, animated: true, completion: nil)
        
    }
    
    // send video when sendbutton pressed
    @IBAction func selectVideoPressed(_ sender: Any) {
        flag = false
        let imagecontroller = UIImagePickerController()
        imagecontroller.delegate = self
        imagecontroller.sourceType = UIImagePickerController.SourceType.photoLibrary
        //imagecontroller.mediaTypes = ["public.movie"]
        imagecontroller.mediaTypes = [kUTTypeMovie as String]
        imagecontroller.videoQuality = .typeHigh
        imagecontroller.allowsEditing = true
        present(imagecontroller, animated: true, completion: nil)
        
        
    }
    // check if video has been saved successfully
    @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
       let title = (error == nil) ? "Success" : "Error"
        let message = (error == nil) ? "Saved Video" : "Video was not saved"
       
       let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
       present(alert, animated: true, completion: nil)
    }
    
    var imageReference: StorageReference {
        return Storage.storage().reference().child("videos")
    }
    

    //select video from photo library and save the video to photo library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        //decide to store video or send video
        if flag == false{
            if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL]  {
            print("Here is the file URL: ", videoUrl)
            
            let currentid = (Auth.auth().currentUser?.uid)!
            
            let storageRef = Storage.storage().reference().child("\(currentid)"+".mov")
            let videoData = NSData(contentsOf: videoUrl as! URL)
            
            storageRef.putData(videoData! as Data, metadata: nil){
                (metadata,error) in
                if error != nil{
                    print("Failed upload of video:", error)
                    let alert = UIAlertController(title: "Video", message: error as! String, preferredStyle: .alert)
                                   alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                                   self.present(alert, animated: true, completion: nil)
                    return
                }
               
                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print("download url has some problem")
                        let alert = UIAlertController(title: "Video", message: error as! String, preferredStyle: .alert)
                                       alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                                       self.present(alert, animated: true, completion: nil)
                        return
                    }
                }
                
                    
                let alert = UIAlertController(title: "Video", message: "Sent Video", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)

                
            }
            
        var selectedImageFromPicker : UIImage?
    
    
        self.dismiss(animated: true, completion: nil)
            
    }
        }
        // when press recordvideo button, run this code
        if flag == true{

        dismiss(animated: true, completion: nil)
        
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
        mediaType == (kUTTypeMovie as String),
        let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,
        UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
        else { return }
        
        // Handle a movie capture
            
        UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        
}
}




