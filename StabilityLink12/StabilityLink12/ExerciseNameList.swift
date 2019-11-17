//
//  ExerciseNameList.swift
//  StabilityLink12
//
//  Created by Bin Xiong on 2019-11-03.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

    var allExercises:[Exercise] = []
    var ExerciseIndex=0
    var exerciseID = ""

class ExerciseNameList: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        allExercises.removeAll()
        
        
        // reference database
        let db = Firestore.firestore()
        let exercise = db.collection("exercises")
        
        exercise.getDocuments{ (snapshot, err) in
            for document in snapshot!.documents {
                let documentData = document.data()
                let newExercise = Exercise()
                
                newExercise.exerciseName = document.get("name") as! String
                newExercise.description = document.get("description") as! String
                newExercise.patientDone = document.get("patientDone") as! String
                newExercise.physioReps = document.get("physioReps") as! String
                newExercise.physioSet = document.get("physioSet") as! String
                
                allExercises.append(newExercise)
            }
            self.tableView.reloadData()
        }

        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allExercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ExerciseList", for: indexPath)
        let dessert = allExercises[indexPath.row].exerciseName
        cell.textLabel?.text = dessert
        return cell
    }
    
    /*
     * When a cell is tapped
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        exerciseID = allExercises[indexPath.row].exerciseName
        performSegue(withIdentifier: "ExerciseMain", sender: self)
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
