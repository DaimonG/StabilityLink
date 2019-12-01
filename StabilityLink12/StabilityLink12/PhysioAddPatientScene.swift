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
    var userEmail = ""
    var ref:DatabaseReference?
    var handle1: DatabaseHandle?
    var handle2: DatabaseHandle?
    // Linking 3 Text Fields
    @IBOutlet weak var emailAddress: UITextField!
    
    @IBOutlet weak var errorlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // setting UI elements
        emailAddress.delegate = self
        emailAddress.placeholder = "Enter Patient Email"
        errorlabel.alpha = 0

        // Functionality to move keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    func errorinfo(_ message:String){
        
        errorlabel.text = message
        errorlabel.alpha = 1
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailAddress.resignFirstResponder()
        
        
    }
    
    func removehandle(){
        guard let handle = handle1 else{
            print("i am not remove the handle1")
            return
        }
        print("remove the handle1")
        self.ref?.child("users").removeObserver(withHandle: handle)
        
     
    }
    
    
    // Load Screen Function
   
    @IBAction func donetapped(_ sender: Any) {
    
    // if the done button was tapped
    
            // get the users email
            userEmail = emailAddress.text!
            if userEmail == ""{
                return self.errorinfo("Please enter the patient email")
            }
            
            // blank strings
            var userid = ""
            var firstName = ""
            var lastName = ""
            var age = ""
            var emailaddress = ""
            var rolename = ""
        
            // reference database
            let db = Firestore.firestore()
            let users = db.collection("users")
            
        // find user that matches entered email address
        users.whereField("email", isEqualTo: userEmail).getDocuments() { (querrySnapshot, err) in
            allPatients.removeAll()
            let querrySnapshot = querrySnapshot
            if let err = err {
                print("Error getting documents: \(err)")
            }
            if querrySnapshot!.isEmpty{
                return self.errorinfo("This email is not existed")
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
                    rolename = document.get("role") as! String
                
                    // add the new patient to the patients array
                    // allPatients.append(newPatient)
                    // print(allPatients)
                } // end of new patient document
                if rolename == "physio"{
                    return self.errorinfo("You cannot add physio as your patient")
                }
                
                // must find the current users id and push the new patient to this document
                let currentid = (Auth.auth().currentUser?.uid)!
                var docid = ""
                var flag:[Bool] = [false]
               
               self.ref?.child("users").child(currentid).child("patientDoc").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                allPatients.removeAll()
                if snapshot.exists(){
                    self.removehandle()
                    print("nidsnoidnsandoisadniosandoiadinosa")
                    for routine in snapshot.children.allObjects as![DataSnapshot]{
                        let snap = routine.value as?[String:String]
                        
                        let id = snap?["uid"] as! String
                        
                        if(id == userid)
                        {
                            
                            flag[0] = true
                        }
                
                        if flag[0]{
                
                            return self.errorinfo("You have been already added this patient")
                        }
                        
                        
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
                        /*
                            let post = ["firstname" : firstName,"lastname" : lastName, "age" : age, "uid" : userid]
                            let childupdates = ["/users/\(currentid)/patientDoc/\(userid)" : post]
                        self.ref?.updateChildValues(childupdates)
                        */
                        print("i am here")
                        let post = ["firstname" : firstName,"lastname" : lastName, "age" : age, "uid" : userid]
                        self.ref?.child("users").child(currentid).child("patientDoc").child(userid).setValue(post)
                       
                            let homeStoryboard = UIStoryboard(name: "physioHome", bundle: nil)
                        self.ref?.child("users").child(currentid).removeAllObservers()
                            let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "PhysicalTherapistHome")
                            self.view.window?.rootViewController = homeViewController
                            self.view.window?.makeKeyAndVisible()
                        //users.document(docid).collection("patients").addDocument(data: ["firstname" : firstName, "lastname" : lastName, "uid" : userid])
                        
                    }
                    self.removehandle()
                    }
                    else{
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
                        /*
                        let post = ["firstname" : firstName,"lastname" : lastName, "age" : age, "uid" : userid]
                        let childupdates = ["/users/\(currentid)/patientDoc/\(userid)" : post]
                        self.ref?.updateChildValues(childupdates)
                        */
                        print("dsadsadsadsadsasddsadsadas")
                        let post = ["firstname" : firstName,"lastname" : lastName, "age" : age, "uid" : userid]
                        self.ref?.child("users").child(currentid).child("patientDoc").child(userid).setValue(post)
                        self.removehandle()
                        let homeStoryboard = UIStoryboard(name: "physioHome", bundle: nil)
                        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "PhysicalTherapistHome")
                        //allPatients.removeAll()
                        self.ref?.child("users").child(currentid).removeAllObservers()
                        self.view.window?.rootViewController = homeViewController
                        self.view.window?.makeKeyAndVisible()
                    }
                    allPatients.removeAll()
                    
                })
               
                
            } // end else
            
        } // end querry
        allPatients.removeAll()
    } // end of done segue


        
    
    @IBAction func canceltapped(_ sender: Any) {
        allPatients.removeAll()
        let homeStoryboard = UIStoryboard(name: "physioHome", bundle: nil)
        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "PhysicalTherapistHome")
        allPatients.removeAll()
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
        
        
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
