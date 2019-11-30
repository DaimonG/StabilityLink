//
//  PhysioViewStatistics.swift
//  StabilityLink12
//
//  Created by Daimon Gill on 2019-11-29.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class PhysioViewStatistics: UIViewController {

    var xValue:[String] = []
    var yValue:[String] = []
    var ref:DatabaseReference?
    var exerName = ""
    var TimesCount = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Pull ExerciseData using nested loop
        self.ref = Database.database().reference()
        self.ref?.child("users").child(currentPatient).child("routines").child(selectedRoutine).observeSingleEvent(of: DataEventType .value, with: { (snapshot) in
            for routine in snapshot.children.allObjects as![DataSnapshot]{
                let snap = routine.value as? [String : String]
                let exercisename = snap?["exercisename"]
                let timesdone = snap?["patientdone"]
                self.exerName = exercisename!
                self.TimesCount = timesdone!
                self.xValue.append(self.exerName)
                self.yValue.append(self.TimesCount)
                
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
