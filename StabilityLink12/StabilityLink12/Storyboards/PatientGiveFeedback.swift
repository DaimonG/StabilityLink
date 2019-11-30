//
//  PatientGiveFeedback.swift
//  StabilityLink12
//
//  Created by Daimon Gill on 2019-11-29.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class PatientGiveFeedback: UIViewController {

    @IBOutlet weak var HardButton: SLButton!
    

    @IBOutlet weak var GoodButton: SLButton!
    
    let currentid = (Auth.auth().currentUser?.uid)!
    @IBOutlet weak var EasyButton: SLButton!
    var ref:DatabaseReference?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        // Do any additional setup after loading the view.
        // Set Button Text
    HardButton.setTitle("Hard", for: .normal)
    GoodButton.setTitle("Good", for: .normal)
    EasyButton.setTitle("Easy", for: .normal)
        
        
    }
 
    
    @IBAction func HardButtonPressed(_ sender: Any) {
        self.ref?.child("users").child(currentid).child("routines").child(patientRoutineTapped).child(patientTapsExercise).updateChildValues(["patientfeedback": "Hard"])
        self.performSegue(withIdentifier: "SavingFeedback", sender: nil)
    }
    
    @IBAction func GoodButtonPressed(_ sender: Any) {
        self.ref?.child("users").child(currentid).child("routines").child(patientRoutineTapped).child(patientTapsExercise).updateChildValues(["patientfeedback": "Good"])
        self.performSegue(withIdentifier: "SavingFeedback", sender: nil)
    }
    
    @IBAction func EasyButtonPressed(_ sender: Any) {
        self.ref?.child("users").child(currentid).child("routines").child(patientRoutineTapped).child(patientTapsExercise).updateChildValues(["patientfeedback": "Easy"])
        self.performSegue(withIdentifier: "SavingFeedback", sender: nil)
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
