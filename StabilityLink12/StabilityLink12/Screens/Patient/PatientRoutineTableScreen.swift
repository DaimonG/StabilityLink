//
//  PatientRoutineTableScreen.swift
//  StabilityLink12
//
//  Created by Alex Makasoff on 2019-11-11.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

var patientRoutineTapped = ""

var allAssignedPatientRoutines:[Routines] = []
class PatientRoutineTableScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var PatientRoutines: UITableView!
    
    // Reference Database
    var ref:DatabaseReference?
    
    // Keys Array
    var patientKeys:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.PatientRoutines.register(UITableViewCell.self, forCellReuseIdentifier: "RoutineCell")
        self.PatientRoutines.tableFooterView = UIView()
        
        PatientRoutines.delegate = self
        PatientRoutines.dataSource = self
        
        // Begin to load patient routines
        self.ref = Database.database().reference()
        var currentid = (Auth.auth().currentUser?.uid)!
        self.ref?.child("users").child(currentid).child("routines").observe(.value, with: {(snapshot) in
            allAssignedPatientRoutines.removeAll()
            
            if let data = snapshot.value as? [String: Any]{
                print(data)
                
                self.patientKeys = Array(data.keys)
                print(self.patientKeys)
                
                for x in self.patientKeys {
                    let routinename = Routines()
                    routinename.name = x
                    allAssignedPatientRoutines.append(routinename)
                    self.PatientRoutines.reloadData()
                }
            }
        })
    }
    
    /*
     * Function to count the rows in the table
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAssignedPatientRoutines.count
    }
    
    /*
     * Function to create a cell
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutineCell", for: indexPath)
        cell.textLabel?.text = allAssignedPatientRoutines[indexPath.row].name
        return cell
    }
    /*
     * Function for when a cell is tapped in the table
     */
    func tableView (_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        patientRoutineTapped = allAssignedPatientRoutines[indexPath.row].name
        print(patientRoutineTapped)
        self.performSegue(withIdentifier: "ToRoutineDetails", sender: nil)
        
    }
}
