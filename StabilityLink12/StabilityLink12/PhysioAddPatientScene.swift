//
//  PhysioAddPatientScene.swift
//  StabilityLink12
//
//  Created by Daimon Gill on 2019-10-30.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit

class PhysioAddPatientScene: UIViewController, UITextFieldDelegate {

    var firstName:String = ""
    var lastName:String = ""
    var patientAge:String = ""
    
    // Linking 3 Text Fields
   
    @IBOutlet weak var fName: UITextField!
    
    @IBOutlet weak var lName: UITextField!
    
    @IBOutlet weak var age: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fName.delegate = self
        lName.delegate = self
        age.delegate = self

        // Do any additional setup after loading the view.
    }
    
    // Load Screen Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            firstName = fName.text!
            lastName = lName.text!
            patientAge = age.text!
        }
    }
    
    // Hide Keyboard Function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.view.endEditing(true)
           return true
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
