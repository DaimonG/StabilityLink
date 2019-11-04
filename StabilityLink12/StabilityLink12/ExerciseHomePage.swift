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







class ExerciseHomePage: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
{
    
    var size = 0
    var ExerciseArray:[ExerciseListTable] = []
    var RoutineName = "July"
    @IBOutlet weak var ExerciseTable: UITableView!
    
    @IBOutlet weak var RoutinesName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.ExerciseTable.tableFooterView = UIView() // was commented
        
        
        ExerciseTable.delegate = self
        ExerciseTable.dataSource = self
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        size = ExerciseArray.count
        print(size)
        return ExerciseArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell
    {
        
        let cell:UITableViewCell = self.ExerciseTable.dequeueReusableCell(withIdentifier: "ExerciseCell") as UITableViewCell!
        
    
        cell.textLabel?.text = ExerciseArray[indexPath.row].name
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "ToExercise", sender: self)
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        
        
        
        
        
        if segue.destination is StartExercise
        {
            let destination = segue.destination as? StartExercise
            let index = ExerciseTable.indexPathForSelectedRow?.row
            destination?.StartExerciseList = ExerciseArray[index!]
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:IndexPath ) {
        if editingStyle == .delete{
            ExerciseArray.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    @IBAction func back(segue:UIStoryboardSegue)
    {
        
    }
    @IBAction func backExercise(segue:UIStoryboardSegue)
    {
        
    }
    
    @IBAction func finish(segue:UIStoryboardSegue) {
        // Extracts data from the add patient screen
        let newExerciseList = segue.source as! ExerciseList
        
        
        let newExercise = ExerciseListTable()
        newExercise.name = newExerciseList.name
        newExercise.describution = newExerciseList.Des
        newExercise.reps = newExerciseList.stringRepsNumber
        newExercise.sets = newExerciseList.stringSetNumber
        
        
        
        
        
        ExerciseArray.append(newExercise)
        
        
        
        
        
        ExerciseTable.reloadData()
    }
    
    
    
    
    
}

