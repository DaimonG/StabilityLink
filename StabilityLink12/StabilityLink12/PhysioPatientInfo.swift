//
//  PhysioPatientInfo.swift
//  StabilityLink12
//
//  Created by Bin Xiong on 2019-11-2.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//
import UIKit
class TempExerciseListTable {
    var reps = ""
    var sets = ""
    var name = ""
    var describution=""
    
    
}

class RoutinesNameList {
    var ClassRoutiensName = ""
   
}
var RoutinesArray:[RoutinesNameList] = []
var TempSize = 0
var TemSets:[String] = []
var TemDescribution:[String] = []
var TemName:[String] = []
var temReps:[String] = []

var currentPatient = ""

class PhysioPatientInfo: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    var TemExerciseArray:[TempExerciseListTable] = []
    // Connecting UI Elements
    @IBOutlet weak var PatientFirstName: UILabel!
    
    @IBOutlet weak var PatientLastName: UILabel!
    
    @IBOutlet weak var PatientAge: UILabel!
    
    
    @IBOutlet weak var RoutinesTable: UITableView!
    

    var totalRoutines = 0
    
    var patientRoutines:[String]? = []
    
    // Patient Object that is optional
    var tPatient: Patients?
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        PatientFirstName.text = tPatient?.firstName
        PatientLastName.text = tPatient?.lastName
        PatientAge.text = tPatient?.age
        currentPatient = (tPatient?.UID)!
        
        //patientRoutines = tPatient?.routines
        
        self.RoutinesTable.register(UITableViewCell.self, forCellReuseIdentifier: "RoutineCell")
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        self.RoutinesTable.tableFooterView = UIView()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        RoutinesTable.delegate = self
        RoutinesTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    @IBAction func exitInfoPage(segue:UIStoryboardSegue)
    {
        
    }
    @IBAction func TemExerciseToInforPage(segue:UIStoryboardSegue)
    {
        
    }
    @IBAction func saveAllexercise(segue:UIStoryboardSegue) {
        // Extracts data from the add patient screen
        let newRoutineList = segue.source as! ExerciseHomePage
        
        
        let newRoutine = RoutinesNameList()
        let newArray = TempExerciseListTable()
        //newRoutine.ClassRoutiensName = newRoutineList.RoutineName
        TempSize = newRoutineList.size
        RoutinesArray.append(newRoutine)
        RoutinesTable.reloadData()
        var i = 0
        while i < TempSize{
            //newArray.name = newRoutineList.ExerciseArray[i].name
            //newArray.describution = newRoutineList.ExerciseArray[i].describution
            //newArray.reps = newRoutineList.ExerciseArray[i].reps
            //newArray.sets = newRoutineList.ExerciseArray[i].sets
            TemName.append(newArray.name)
            TemDescribution.append(newArray.describution)
            temReps.append(newArray.reps)
            TemSets.append(newArray.sets)
            RoutinesTable.reloadData()
            i = i+1
            
        }
       
       
        
        
    }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoutinesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"RoutineCell", for: indexPath)
        
        cell.textLabel?.text = RoutinesArray[indexPath.row].ClassRoutiensName
        return cell
        
    }
   
  
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        performSegue(withIdentifier: "ToTempExercise", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    /*
     * Delete Table Cell Function
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:IndexPath )
    {
        if editingStyle == .delete{
            RoutinesArray.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}
