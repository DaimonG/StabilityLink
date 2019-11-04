//
//  PhysioPatientInfo.swift
//  StabilityLink12
//
//  Created by Bin Xiong on 2019-11-2.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit

class RoutinesNameList {
    var ClassRoutiensName = ""
   
}
var RoutinesArray:[RoutinesNameList] = []
var desserts:[String] = []
class PhysioPatientInfo: UIViewController, UITableViewDelegate, UITableViewDataSource  {

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
        
        patientRoutines = tPatient?.routines
        
        self.RoutinesTable.register(UITableViewCell.self, forCellReuseIdentifier: "RoutineCell")
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        self.RoutinesTable.tableFooterView = UIView()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        RoutinesTable.delegate = self
        RoutinesTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddNewRoutine(_ sender: Any) {
        let alert = UIAlertController(title: "Add New Routine", message: nil, preferredStyle: .alert)
        alert.addTextField {(dessertTF) in dessertTF.placeholder = "Enter Name"
            
            
        }
        
        let action = UIAlertAction(title: "Add", style: .default){
            (_) in guard let dessert = alert.textFields? .first? .text else { return }
            desserts.append(dessert)
            self.RoutinesTable.reloadData()
            
        }
        
        alert.addAction(action)
        present(alert, animated:true)
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return desserts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"RoutineCell", for: indexPath)
        let dessert = desserts[indexPath.row]
        cell.textLabel?.text = dessert
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        performSegue(withIdentifier: "ToExerciseHome", sender: self)
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
    
    // Might need to add done and cancel segues???
    
    
    //(segue:UIStoryboardSegue)
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
