//
//  SignUpPage.swift
//  StabilityLink12
//
//  Created by BinXiong on 2019/11/10.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


var unique_email_id = ""

class SignUpPage: UIViewController {
    
    
    
    @IBOutlet weak var Firstnametext: UITextField!
    
    @IBOutlet weak var Lastnametext: UITextField!
    
    @IBOutlet weak var Agetext: UITextField!
    
    @IBOutlet weak var Usernametext: UITextField!
    
    @IBOutlet weak var Emailtext: UITextField!
    
    @IBOutlet weak var Passwordtext: UITextField!
    
    @IBOutlet weak var Signupbutton: UIButton!
    
   
    @IBOutlet weak var rolelable: UILabel!
    
    @IBOutlet weak var errorlabel: UILabel!
    var ref: DatabaseReference?
    
    var current_role = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        ref = Database.database().reference()
       
    }

    func setUpElements(){
        errorlabel.alpha = 0
        Utilities.styleTextField(Firstnametext)
        Utilities.styleTextField(Lastnametext)
        Utilities.styleTextField(Agetext)
        Utilities.styleTextField(Usernametext)
        Utilities.styleTextField(Emailtext)
        Utilities.styleTextField(Passwordtext)
        Utilities.styleFilledButton(Signupbutton)
        
    }
    
    @IBAction func PatientTapped(_ sender: Any) {
        current_role = "patient"
        rolelable.text = current_role
    }
    
    @IBAction func PhysicoTapped(_ sender: Any) {
        current_role = "physio"
        rolelable.text = current_role
    }
    
    // check the field and validate that the data is corrent. if everything is corrent, this method returns
    // nil, otherwise, it returns the error message
    func validateFields() -> String? {
        // check that all fields are filled in
        if (Firstnametext.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        Lastnametext.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        Agetext.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        Usernametext.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        Emailtext.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            Passwordtext.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            return "Please fill in all fields"
        }
        //check role
        if (current_role == ""){
            return "Please choose a role"
        }
        
        // check if the password is secure
        let cleanpassword = Passwordtext.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanpassword) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number"
        }
        
        return nil
    }
    
    func showError(_ message:String){
        errorlabel.text = message
        errorlabel.alpha = 1
        
    }
    
     func transitiontohome(){
     let Homepagecontroller = storyboard?.instantiateViewController(withIdentifier: "homepageboard") as? HomePage
     
     view.window?.rootViewController = Homepagecontroller
     view.window?.makeKeyAndVisible()
     
     }
 
    // click signup button
    @IBAction func SignupTapped(_ sender: Any) {
        //validate the fields
        let error = validateFields()
        if error != nil{
            // there is some wrong with the fields, show error message
            showError(error!)
        }
        else{
            //create cleaned versions of the data
            let firstname = Firstnametext.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = Lastnametext.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = Emailtext.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let username = Usernametext.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let age = Agetext.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = Passwordtext.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create the users
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                //check for errors
                if err != nil{
                    // there was an error creating the user
                    self.showError("Error creating user")
                }
                else{
                    // user was created successfully, now store the first name,last name, age
                    let db = Firestore.firestore()
                    unique_email_id = result!.user.uid
                    db.collection("users").addDocument(data: ["uid" : result!.user.uid, "email": email,"firstname" : firstname, "lastname" : lastname,"role" : self.current_role, "age" : age , "username" : username], completion: { (error) in
                        if error != nil {
                            //show message
                            self.showError("User data couldn't be saved into database")
                        }
                    })
                    
                    let newuserid = (Auth.auth().currentUser?.uid)!
                    let post = [ "firstname" : firstname, "lastname" : lastname ,"email": email,"role" : self.current_role, "age" : age , "username" : username] as [String: Any]
                    let childupdates = ["/users/\(newuserid)" : post]
                    self.ref?.updateChildValues(childupdates)
                   
                   
                    //transition to home screen
                    self.transitiontohome()
                }
            }
            
        }
        
        
        
        
        //transition to the home screen
    }
}
