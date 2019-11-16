//
//  PhysicalTherapistHomeScene.swift
//  StabilityLink12
//
//  Created by Daimon Gill on 2019-10-30.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore// GLOBAL VARIABLES

// Patients Class
class Patients {
    var firstName = ""
    var lastName = ""
    var age = ""
    var UID = ""
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
    
    @IBOutlet weak var headerLabel: UILabel!
    
    var cellReuseIdentifier = "cell"
    
   
    /*
     * Function to load the view
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = "All Patients:"
        // Register the table view cell class and its reuse id
        self.PatientsTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        // (optional) include this line if you want to remove the extra empty cell divider lines
        self.PatientsTable.tableFooterView = UIView() // was commented

        // This view controller itself will provide the delegate methods and row data for the table view.
        PatientsTable.delegate = self
        PatientsTable.dataSource = self
    }

    @IBAction func loadData(_ sender: Any) {
        // start by emptying the array
        allPatients = []
        print("ENTER LOAD DATA")
        print(allPatients)
        // now copy all contents from the database back to the array
        
        // reference database
        let db = Firestore.firestore() // reference database as a firestore
        let users = db.collection("users") // reference users collection
        
        // get the current user id
        let currentid = (Auth.auth().currentUser?.uid)!
        users.whereField("uid", isEqualTo: currentid).getDocuments() { (snapshot, error) in
            if let error = error {
                print("Unable to get current UID: \(error)")
            }
            else{
                for document in snapshot!.documents{
                    let currentPatients = document.get("data") as! NSDictionary // get the data map from the document
                    print(currentPatients)
                    // loop through the map and extract each entry and also create a new object and append to the array
                    for (key, value) in currentPatients {
                        print("LOOP")
                        var firstname = key as! String
                        var uid = value as! String
                        
                        let newPatient = Patients()
                        
                        newPatient.firstName = firstname
                        newPatient.UID = uid
                        
                        allPatients.append(newPatient)
                        print(allPatients)
                    } // end for loop
                } // end document extraction
            }// end else
        }
        
        PatientsTable.reloadData()
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
        // Reload the table
        PatientsTable.reloadData()
        print("HERE")
    }
    
    // If it is the cancel segue, do nothing
    @IBAction func cancel(segue:UIStoryboardSegue) {
      // Do Nothing
        PatientsTable.reloadData()
        print("HERE2")
    }

    
}
