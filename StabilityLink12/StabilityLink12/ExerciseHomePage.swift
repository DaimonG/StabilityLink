//
//  ExerciseHomePage.swift
//  StabilityLink12
//
//  Created by Bin Xiong on 11/3/19.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore


// The Exercise Class
class ExerciseListTable {
    var reps = ""
    var sets = ""
    var name = ""
    var describution=""
    
    
}

var newRoutine:[Exercise] = []


class ExerciseHomePage: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
{
  
    
    var size = 0
    var count = 0
    
    
    @IBOutlet weak var ExerciseTable: UITableView!
    var ref:DatabaseReference?
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newRoutine.removeAll()
        
        print("View Loading",currentRoutine)
       
        print("current routine: ", currentRoutine)
        print("current patient: ", currentPatient)
        errorLabel.alpha = 0
        self.ExerciseTable.register(UITableViewCell.self, forCellReuseIdentifier: "ExerciseCell")
        self.ExerciseTable.tableFooterView = UIView() // was commented
        
        ExerciseTable.delegate = self
        ExerciseTable.dataSource = self
        
        self.ref = Database.database().reference()
        
        self.ref?.child("users").child(currentPatient).child("routines").child(currentRoutine).observe( DataEventType.value, with: { (snapshot) in
            newRoutine.removeAll()
            
            
        for routine in snapshot.children.allObjects as![DataSnapshot]{
            let snap = routine.value as?[String : String]
            print("iamsnap",snap)
            
            let name = snap?["exercisename"]
            print("Exercise Name: ", name)
            
            let newExercise = Exercise()
            
            newExercise.exerciseName = name!
            
            newRoutine.append(newExercise)
            self.ExerciseTable.reloadData()
        }
    })
}
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        size = newRoutine.count
        return size
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell
    {
        
        let cell:UITableViewCell = self.ExerciseTable.dequeueReusableCell(withIdentifier: "ExerciseCell") as UITableViewCell!
        
        cell.textLabel?.text = newRoutine[indexPath.row].exerciseName
        print("hello1")
        
        return cell
    }
    
    /*
     * If a cell is tapped
     */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        errorLabel.alpha = 1
    }
    
    
    @IBAction func finishAndSave(_ sender: Any) {
        // push a routine name to the routine that was just created
       /* let post1 = ["routinename" : currentRoutine]
        let childupdates1 = ["/users/\(currentPatient)/routines/\(currentRoutine)" : post1]
        self.ref?.updateChildValues(childupdates1)*/
        
        self.performSegue(withIdentifier: "DoneToPhysioHome", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {

    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    /*
     * Delete a cell
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:IndexPath ) {
        if editingStyle == .delete{
            newRoutine.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    /*
     *
     */
    @IBAction func back(segue:UIStoryboardSegue)
    {
        
    }
    /*
    @IBAction func backInfoPage(_ sender: Any)
    {
        let infoStoryboard = UIStoryboard(name: "physioHome", bundle: nil)
        if #available(iOS 13.0, *) {
            let infoview = infoStoryboard.instantiateViewController(identifier: "InfoPage")
            self.view.window?.rootViewController = infoview
            self.view.window?.makeKeyAndVisible()
        }
        
       
        
        
    }
 */
    
    @IBAction func ToCreateRoutine(segue:UIStoryboardSegue)
    {
        print("RETURNED 100")
        print("View Loaded")
        
       
    }
    
}

