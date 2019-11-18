//
//  PatientViewExercise.swift
//  StabilityLink12
//
//  Created by Daimon Gill on 2019-11-17.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class PatientViewExercise: UIViewController {
    @IBOutlet weak var ExerciseImage: UIImageView!
    
    @IBOutlet weak var ExerciseDescribution: UIImageView!
    
    
    @IBOutlet weak var ExerciseSetNumber: UILabel!
    
    @IBOutlet weak var ExerciseReps: UILabel!
    
    // Reference Database
    
    var ref:DatabaseReference?
    
    var setNumber = ""
    var repNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var setNumber = ""
        var repNumber = ""
        
        ExerciseImage.image = UIImage(named: ("\(patientTapsExercise)" + ".png"))
        
        ExerciseDescribution.image = UIImage(named: ("Old" + "\(patientTapsExercise)" + ".png"))
        
        self.ref = Database.database().reference()
        let currentid = (Auth.auth().currentUser?.uid)!
        
        self.ref?.child("users").child(currentid).child("routines").child(patientRoutineTapped).child(patientTapsExercise).observe(.value, with: {(snapshot) in
                
            if let data = snapshot.value as? [String: Any]{
                print(data)
                self.ExerciseSetNumber.text = data["physioset"] as! String
                self.ExerciseReps.text = data["physioreps"] as! String
            }
        })
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
