//
//  PhysioRoutineInformation.swift
//  StabilityLink12
//
//  Created by Daimon Gill on 2019-11-17.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

var routineExercises:[Exercise] = []

class PhysioRoutineInformation: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ExerciseTable: UITableView!
    var ref:DatabaseReference?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ExerciseTable.register(UITableViewCell.self, forCellReuseIdentifier: "ExerciseCell")
        self.ExerciseTable.tableFooterView = UIView()
        
        ExerciseTable.delegate = self
        ExerciseTable.dataSource = self
        self.ref = Database.database().reference()
        self.ref?.child("users").child(currentPatient).child("routines").child(selectedRoutine).observe(DataEventType.value, with: { (snapshot) in
            routineExercises.removeAll()
            for routine in snapshot.children.allObjects as![DataSnapshot]{
                let snap = routine.value as? [String : String]
                print("routine snap", snap)
                
                let name = snap?["exercisename"]
                print(name)
                
                let newExercise = Exercise()
                newExercise.exerciseName = name!
                
                routineExercises.append(newExercise)
                self.ExerciseTable.reloadData()
            }
        })
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routineExercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath)
        let dessert = routineExercises[indexPath.row].exerciseName
        cell.textLabel?.text = dessert
        return cell
    }
    
    /*
     * When a cell is tapped
     */
    func tableView(_ tableView: UITableView, disSelectRowAt indexPath: IndexPath){
        print("CELL TAPPED")
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
