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
        imagecontroller.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
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
            storageRef.putData(videoData as! Data)
            /*
            if let videoData = NSData(contentsOf: videoUrl as! URL) as Data? {
                storageRef.putFile(from: videoUrl as! URL, metadata: nil) { (metadata, error) in
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

                    return
                }
            }*/
            
            
        var selectedImageFromPicker : UIImage?
    
    
        self.dismiss(animated: true, completion: nil)
            
        
    }
 
    
   /* func imagePiockerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]){
        
        if let videoURL = info[UIImagePickerController] as? NSURL {
            
        }
    }*/
    
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
