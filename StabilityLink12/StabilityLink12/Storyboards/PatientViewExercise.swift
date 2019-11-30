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
    
    @IBOutlet weak var DoneButton: UIButton!
    
    @IBOutlet weak var FeedBackButton: UIButton!
    @IBOutlet weak var ExerciseSetNumber: UILabel!
    
    @IBOutlet weak var ExerciseReps: UILabel!
    
    // Reference Database
    
    var ref:DatabaseReference?
    
    var setNumber = ""
    var repNumber = ""
    var count = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var setNumber = ""
        var repNumber = ""
        var count = ""
        DoneButton.setTitle("Done", for: .normal)
        
        FeedBackButton.setTitle("Feedback", for: .normal)
        
        
        ExerciseImage.image = UIImage(named: ("\(patientTapsExercise)" + ".png"))
        
        ExerciseDescribution.image = UIImage(named: ("Old" + "\(patientTapsExercise)" + ".png"))
        
        self.ref = Database.database().reference()
        let currentid = (Auth.auth().currentUser?.uid)!
        
        self.ref?.child("users").child(currentid).child("routines").child(patientRoutineTapped).child(patientTapsExercise).observeSingleEvent(of: .value, with: {(snapshot) in
                
            if let data = snapshot.value as? [String: Any]{
                print(data)
                self.ExerciseSetNumber.text = data["physioset"] as! String
                self.ExerciseReps.text = data["physioreps"] as! String
                self.setNumber = data["physioset"] as! String
                self.repNumber = data["physioreps"] as! String
                self.count = data["patientdone"] as! String
            }
        })
    }
    

    @IBAction func DoneButtonPressed(_ sender: Any) {
        // Update Database Counter
        var intcount = (Int(count))! + 1
        let currentid = (Auth.auth().currentUser?.uid)!
        var stringcount = (String(intcount))
       print("intcount",intcount)
        let post = ["patientdone" : stringcount,"exercisename" : patientTapsExercise, "physioreps" : repNumber, "physioset" : setNumber]
        let childupdates = ["/users/\(currentid)/routines/\(patientRoutineTapped)/\(patientTapsExercise)" : post]
        print("childupdate",childupdates)
        self.ref?.updateChildValues(childupdates)
        
        self.performSegue(withIdentifier: "DoneExercise", sender: nil)
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
