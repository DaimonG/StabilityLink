//
//  PhysicalTherapistHomeScene.swift
//  StabilityLink12
//
//  Created by Daimon Gill on 2019-10-30.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit

// Patients Class
class Patients {
    var firstName = ""
    var lastName = ""
    var age = 0
}


class PhysicalTherapistHomeScene: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Connect to StoryBoard Element
     @IBOutlet weak var PatientsTable: UITableView!
    
    
    
    // Data model: These strings will be the data for the table view cells
    var patients:[String] = ["Patient 1","Patient 2","Patient 3"]

    var newPatientFName: String = ""
    var newPatientLName: String = ""
    var newPatientAge: String = ""
    
    var cellReuseIdentifier = "cell"


    
    // Loading The Table
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register the table view cell class and its reuse id
        self.PatientsTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()

        // This view controller itself will provide the delegate methods and row data for the table view.
        PatientsTable.delegate = self
        PatientsTable.dataSource = self
    }

       // number of rows in table view
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.patients.count // the number of rows is based on animals variable
       }

       // create a cell for each row in the table view
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

           // create a new cell if needed or reuse an old one
           let cell:UITableViewCell = self.PatientsTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!

           // set the text from the data model
           cell.textLabel?.text = self.patients[indexPath.row]

           return cell
       }

       // method to run when table view cell is tapped
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("You tapped cell number \(indexPath.row).")
       }
    
    
    // If it is the done segue, we add the new item
    // First we must extract values from the other view controller
     @IBAction func done(segue:UIStoryboardSegue) {
        let newPatientInfo = segue.source as! PhysioAddPatientScene
        newPatientFName = newPatientInfo.firstName
        newPatientLName = newPatientInfo.lastName
        newPatientAge = newPatientInfo.patientAge
        
        patients.append(newPatientFName) // We append the first name
        
        // Reload the table
        PatientsTable.reloadData()
    }
    
    // If it is the cancel segue, do nothing
    @IBAction func cancel(segue:UIStoryboardSegue) {
      
    }

    
}
