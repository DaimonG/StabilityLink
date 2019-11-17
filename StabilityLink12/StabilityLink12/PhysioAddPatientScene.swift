//
//  PhysioAddPatientScene.swift
//  StabilityLink12
//
//  Created by Daimon Gill on 2019-10-30.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class PhysioAddPatientScene: UIViewController, UITextFieldDelegate {

    // Set to an empty string
    var userEmail:String = ""
    var ref:DatabaseReference?
    // Linking 3 Text Fields
    @IBOutlet weak var emailAddress: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // setting UI elements
        emailAddress.delegate = self
        emailAddress.placeholder = "Enter Patient Email"

        // Functionality to move keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    
    
    // Load Screen Function
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if the done button was tapped
        if segue.identifier == "doneSegue" {
            // get the users email
            userEmail = emailAddress.text!
            
            // blank strings
            var userid = ""
            var firstName = ""
            var lastName = ""
            var age = ""
            
            // reference database
            let db = Firestore.firestore()
            let users = db.collection("users")
            
            // find user that matches entered email address
            users.whereField("email", isEqualTo: userEmail).getDocuments() { (querrySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }
                else {
                    //begin patient add steps
                    // create new patient and extract document
                    for document in querrySnapshot!.documents {
                        // extract values from the document
                        userid = document.get("uid") as! String
                        firstName = document.get("firstname") as! String
                        lastName = document.get("lastname") as! String
                        age = document.get("age") as! String
                        
                        // create a patient object and set values
                        let newPatient = Patients()
                        newPatient.firstName = firstName
                        newPatient.UID = userid
                        newPatient.lastName = lastName
                        newPatient.age = age
                        
                        print("About to append")
                        // add the new patient to the patients array
                       // allPatients.append(newPatient)
                       // print(allPatients)
                    } // end of new patient document
                    
                    // must find the current users id and push the new patient to this document
                    let currentid = (Auth.auth().currentUser?.uid)!
                    var docid = ""
                    users.whereField("uid", isEqualTo: currentid).getDocuments() { (snapshot, error) in
                        if let error = error {
                            print("error finding current id")
                        }
                        else{
                            for document in snapshot!.documents{
                                docid = document.documentID
                            }
                        }
                    }
                    let post = ["firstname" : firstName,"lastname" : lastName, "age" : age, "uid" : userid]
                    let childupdates = ["/users/\(currentid)/patientDoc/\(userid)" : post]
                    self.ref?.updateChildValues(childupdates)
                    //users.document(docid).collection("patients").addDocument(data: ["firstname" : firstName, "lastname" : lastName, "uid" : userid])
                    
                } // end else
                   
            } // end querry
            allPatients.removeAll()
        } // end of done segue
    }
    
    
    // Hide Keyboard Function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.view.endEditing(true)
           return true
       }
    
    /*
       * A function that shows the keyboard
       * Apart of functionality to not hide text fields when keyboard is shown
       */
    @objc func keyboardWillShow(notification: NSNotification) {
          if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
              if self.view.frame.origin.y == 0 {
                  self.view.frame.origin.y -= keyboardSize.height
              }
          }
      }
      
      /*
       * A function that hides the keyboard
       * Apart of functionality to not hide text fields when keyboard is shown
       */
      @objc func keyboardWillHide(notification: NSNotification) {
          if self.view.frame.origin.y != 0 {
              self.view.frame.origin.y = 0
          }
      }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
