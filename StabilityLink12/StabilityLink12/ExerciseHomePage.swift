//
//  ExerciseHomePage.swift
//  StabilityLink12
//
//  Created by Bin Xiong on 11/3/19.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit


// The Exercise Class
class ExerciseListTable {
    var reps = ""
    var sets = ""
    var name = ""
    var describution=""
    
    
}

var newRoutine:[Exercise] = []

var currentRoutine = "test"

class ExerciseHomePage: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
{
    @IBOutlet weak var errorlabel: UILabel!
    
    var size = 0
    var count = 0
    
    
    @IBOutlet weak var ExerciseTable: UITableView!
    
    
    @IBOutlet weak var routineName: UITextField!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routineName.placeholder = "Enter New Routine Name"
        print("View Loading",currentRoutine)
       
        print(currentRoutine)
        self.ExerciseTable.tableFooterView = UIView() // was commented
        ExerciseTable.delegate = self
        ExerciseTable.dataSource = self
        errorlabel.alpha = 0
        
    }
    
    func validateFields() -> String? {
        if(routineName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "")
        {
            return "please enter routine name and save it"
        }
        return nil
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
        print("hello")
        
        return cell
    }
    
    /*
     * If a cell is tapped
     */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "ToExercise", sender: self)
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {

      /*  if segue.destination is StartExercise
        {
            let destination = segue.destination as? StartExercise
            let index = ExerciseTable.indexPathForSelectedRow?.row
            destination?.StartExerciseList = newRoutine[index!]
            
        }*/
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
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
    @IBAction func backExercise(segue:UIStoryboardSegue)
    {
        
    }
    
    func showError(_ message:String)
    {
        errorlabel.text = message
        errorlabel.alpha = 1
       
    }
    func transitiontoexercise() {
        currentRoutine = routineName.text!
        print("i ma here", currentRoutine)
        let Homepagecontroller = storyboard?.instantiateViewController(withIdentifier: "ExercisePage") as? ExerciseNameList
        
        view.window?.rootViewController = Homepagecontroller
        view.window?.makeKeyAndVisible()
        
    }
    
    @IBAction func ListTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil{
            showError(error!)
        }
        else{
            self.transitiontoexercise()
        }
    }
    @IBAction func ToCreateRoutine(segue:UIStoryboardSegue)
    {
        print("RETURNED 100")
        print("View Loaded")
        
        ExerciseTable.reloadData()
    }
    
   /* @IBAction func finish(segue:UIStoryboardSegue) {
        // Extracts data from the add patient screen
        let newExerciseList = segue.source as! ExerciseList
        
        
        let newExercise = ExerciseListTable()
      //  newExercise.name = newExerciseList.name
        //newExercise.describution = newExerciseList.Des
        newExercise.reps = newExerciseList.stringRepsNumber
        newExercise.sets = newExerciseList.stringSetNumber
    
        ExerciseArray.append(newExercise)
        ExerciseTable.reloadData()
    }*/
    
    
    
    
    
}

