//
//  PatientExecuteRoutineScreen.swift
//  StabilityLink12
//
//  Created by Alex Makasoff on 2019-11-11.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

var patientAssignedExercises:[Exercise] = []

var patientTapsExercise = ""

class PatientExecuteRoutineScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var PatientExerciseList: UITableView!
    
   var ref:DatabaseReference?
    
   override func viewDidLoad() {
       super.viewDidLoad()

       self.PatientExerciseList.register(UITableViewCell.self, forCellReuseIdentifier: "WorkoutCell")
       self.PatientExerciseList.tableFooterView = UIView()
       
       PatientExerciseList.delegate = self
       PatientExerciseList.dataSource = self
       self.ref = Database.database().reference()
        var currentid = (Auth.auth().currentUser?.uid)!
       self.ref?.child("users").child(currentid).child("routines").child(patientRoutineTapped).observe(DataEventType.value, with: { (snapshot) in
           patientAssignedExercises.removeAll()
           for routine in snapshot.children.allObjects as![DataSnapshot]{
               let snap = routine.value as? [String : String]
               print("routine snap", snap)
               
               let name = snap?["exercisename"]
               print(name)
               
               let newExercise = Exercise()
               newExercise.exerciseName = name!
               
               patientAssignedExercises.append(newExercise)
               self.PatientExerciseList.reloadData()
           }
       })
       
       
       
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return patientAssignedExercises.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath)
       let dessert = patientAssignedExercises[indexPath.row].exerciseName
       cell.textLabel?.text = dessert
       return cell
   }
   
   /*
    * When a cell is tapped
    */
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        patientTapsExercise = patientAssignedExercises[indexPath.row].exerciseName
       print("Tapped: ", patientTapsExercise)
    self.performSegue(withIdentifier: "ToExerciseDetails", sender: nil)
        
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
