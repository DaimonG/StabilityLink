//
//  PhysicalTherapistHomeScene.swift
//  StabilityLink12
//
//  Created by Daimon Gill on 2019-10-30.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit

// GLOBAL VARIABLES
// Patients Class
class Patients {
    var firstName = ""
    var lastName = ""
    var age = ""
    var routines:[String] = []
}

// The Routines Class
class Routines {
    // Stuff
    var exerciseList:[Exercise] = []
    var totalExercise = 0
}

// The Exercise Class
class Exercise {
    var reps = 0
    var sets = 0
}

// Array of patients
var allPatients:[Patients] = [] // start with no patients


// End of Global Variables
class PhysicalTherapistHomeScene: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    // Connect to StoryBoard Element
    @IBOutlet weak var PatientsTable: UITableView!
    
    var cellReuseIdentifier = "cell"
    
   
    /*
     * Function to load the view
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the table view cell class and its reuse id
        self.PatientsTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        // (optional) include this line if you want to remove the extra empty cell divider lines
        self.PatientsTable.tableFooterView = UIView() // was commented

        // This view controller itself will provide the delegate methods and row data for the table view.
        PatientsTable.delegate = self
        PatientsTable.dataSource = self
    }

    /*
     * Function to count how many patients the physiotherapist has in total
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return allPatients.count // the number of cells is the number of patients
    }

    /*
     * Functions to create cells for the tableview
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell
    {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.PatientsTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!

        // gets the text of patient objects
        cell.textLabel?.text = allPatients[indexPath.row].firstName + " " + allPatients[indexPath.row].lastName

           return cell
    }

    /*
     * Function for when the cell is tapped
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // This is the patient that has been selected
        // tappedPatient = allPatients[indexPath.row]
        // We do the segue to 
        performSegue(withIdentifier: "ToPatientInfo", sender: self)
        // print("You tapped cell number \(indexPath.row).")
    }
    
    /*
     * Prepping data to be passed in segues
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is PhysioPatientInfo
        {
            let destination = segue.destination as? PhysioPatientInfo
            let index = PatientsTable.indexPathForSelectedRow?.row
            destination?.tPatient = allPatients[index!]
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    /*
     * Delete Table Cell Function
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:IndexPath ) {
        if editingStyle == .delete{
            allPatients.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    // If it is the done segue, we add the new item
    // First we must extract values from the other view controller
     @IBAction func done(segue:UIStoryboardSegue) {
        
        // Extracts data from the add patient screen
        let newPatientInfo = segue.source as! PhysioAddPatientScene
        
        // Create new Patient Object and assign it values from values passed through new patient screen
        let newPatient = Patients()
        newPatient.firstName = newPatientInfo.firstName
        newPatient.lastName = newPatientInfo.lastName
        newPatient.age = newPatientInfo.patientAge
        
        // Add the new patient to allPatients array
        allPatients.append(newPatient)
        
        // Reload the table
        PatientsTable.reloadData()
    }
    
    // If it is the cancel segue, do nothing
    @IBAction func cancel(segue:UIStoryboardSegue) {
      // Do Nothing
    }

    
}
