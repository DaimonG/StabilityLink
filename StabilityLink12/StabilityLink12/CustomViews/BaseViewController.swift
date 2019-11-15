//
//  BaseViewController.swift
//  StabilityLink12
//
//  Created by Alex Makasoff on 2019-11-12.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class BaseViewController: UIViewController {
    @IBOutlet var button: UIView!
    
    @IBOutlet weak var errorlable: UILabel!
    var bool = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = Colors.slDarkGrey        
        // Do any additional setup after loading the view.
        
        //set firebase reference
        let userID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: userID).getDocuments { (snapshot, error) in
            if error != nil{
                print(error)
            }
            else{
                for document in (snapshot?.documents)!{
                    if let role = document.data()["role"] as? String{
                        if role == "patient"
                        {
                            self.bool = "patient"
                            
                        }
                        else
                        {
                            self.bool = "physio"
                        }
                        
                    }
                    
                }
            }
        }
        setUpElements()
        
        
        
    }
    
    
    func setUpElements(){
        errorlable.alpha = 0
        
        
    }
    @IBAction func patienttapped(_ sender: Any) {
        if bool != "patient"{
            errorlable.alpha = 1
            return errorlable.text = "Your role is not patient"
        }
            
            
        else{
            
            let loginStoryboard = UIStoryboard(name: "patientHome", bundle: nil)
            let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: "PatientHome")
            self.view.window?.rootViewController = loginViewController
            self.view.window?.makeKeyAndVisible()
            
            
        }
    }
    
    @IBAction func physiotapped(_ sender: Any) {
        if bool != "physio"
        {
            errorlable.alpha = 1
            return errorlable.text = "Your role is not physio"
            
        }
        else{
            
            let loginStoryboard = UIStoryboard(name: "physioHome", bundle: nil)
            let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: "PhysicalTherapistHome")
            self.view.window?.rootViewController = loginViewController
            self.view.window?.makeKeyAndVisible()
            
            
            
        }
        
    }
    
}
