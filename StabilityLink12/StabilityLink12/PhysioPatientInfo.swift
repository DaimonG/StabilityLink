//
//  PhysioPatientInfo.swift
//  StabilityLink12
//
//  Created by Daimon Gill on 2019-10-30.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit

class PhysioPatientInfo: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    // Connecting UI Elements
    @IBOutlet weak var PatientFirstName: UILabel!
    
    @IBOutlet weak var PatientLastName: UILabel!
    
    @IBOutlet weak var PatientAge: UILabel!
    
    @IBOutlet weak var RoutinesTable: UITableView!
    
    var cellReuseIdentifier = "cell"
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
        
        self.RoutinesTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        self.RoutinesTable.tableFooterView = UIView()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        RoutinesTable.delegate = self
        RoutinesTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    /*
     * Function to count the number of routines that a patient has
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // CHANGE VALUE OF TOTAL ROUTINES
        return 0 // The number of routines
    }
   
    /*
     * Function to create cells for table view
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell
    {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.RoutinesTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!

        // gets the text of patient objects
         /*
        cell.textLabel?.text = allPatients[indexPath.row].firstName + allPatients[indexPath.row].lastName
        */
           return cell
    }
    
    /*
     * Function for when the Cell is Tapped
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // This is the patient that has been selected
        // tappedPatient = allPatients[indexPath.row]
        // We do the segue to
        // NEED TO CHANGE SEGUE HERE
        performSegue(withIdentifier: "ToPatientInfo", sender: self)
        // print("You tapped cell number \(indexPath.row).")
    }
    
    /*
     * Mandatory Table View Function
     */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    /*
     * Delete Table Cell Function
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:IndexPath )
    {
        if editingStyle == .delete{
            allPatients.remove(at: indexPath.row)
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
