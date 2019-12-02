//
//  PhysioViewExercise.swift
//  StabilityLink12
//
//  Created by Daimon Gill on 2019-11-29.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class PhysioViewExercise: UIViewController {

    // Connect UI Elements
    @IBOutlet weak var ExerciseImage: UIImageView!
    @IBOutlet weak var ExerciseDescription: UIImageView!
    @IBOutlet weak var SetsTitle: UILabel!
    @IBOutlet weak var SetsNumber: UILabel!
    @IBOutlet weak var FeedbackLabel: UILabel!
    @IBOutlet weak var FeedbackValue: UILabel!
    @IBOutlet weak var RepsTitle: UILabel!
    @IBOutlet weak var RepsNumber: UILabel!
    
    // Reference Database
    var ref:DatabaseReference?
    
    // Class Variables
    var setNumber = ""
    var repNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Default Values
        SetsTitle.text = "Sets:"
        RepsTitle.text = "Reps:"
        FeedbackLabel.text = "Feedback:"
        
        // Set Images
        ExerciseImage.image = UIImage(named: ("\(physioTapsExercise)" + ".png"))
        ExerciseDescription.image = UIImage(named: ("Old" + "\(physioTapsExercise)" + ".png"))
        
        
        // Pull Values from Database
        self.ref = Database.database().reference()
        self.ref?.child("users").child(currentPatient).child("routines").child(selectedRoutine).child(physioTapsExercise).observeSingleEvent(of: .value, with: { (snapshot) in
            print("Snapshot Value: ", snapshot)
            print("Selected routine: ", selectedRoutine)
            print("Physio Taps: ", physioTapsExercise)
            
            if let data = snapshot.value as? [String: Any]{
                print("data",data)
                self.SetsNumber.text = (data["physioset"] as! String)
                self.RepsNumber.text = (data["physioreps"] as! String)
                self.FeedbackValue.text = (data[
                    "patientfeedback"] as! String)
            }
            
        })
        // Do any additional setup after loading the view.
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
