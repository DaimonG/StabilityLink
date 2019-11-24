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
import FirebaseFirestore

// GLOBAL VARIABLES

// Patients Class
class Patients {
    var firstName = ""
    var lastName = ""
    var age = ""
    var UID = ""
    
}

// The Routines Class
class Routines {
    // Stuff
    var exerciseList:[Exercise] = []
    var totalExercise = 0
    var name = ""
}

// The Exercise Class
class Exercise {
    var exerciseName = ""
    var description = ""
    var patientDone = ""
    var physioReps = ""
    var physioSet = ""
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
    var firstName = ""
    var lastName = ""
    
    var ref:DatabaseReference?
    var handlereload :DatabaseHandle?
    var handleremove :DatabaseHandle?
    /*
     * Function to load the view
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = "All Patients:"
        allPatients.removeAll()
       
        // Register the table view cell class and its reuse id
        self.PatientsTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        // (optional) include this line if you want to remove the extra empty cell divider lines
        self.PatientsTable.tableFooterView = UIView() // was commented

        // This view controller itself will provide the delegate methods and row data for the table view.
        PatientsTable.delegate = self
        PatientsTable.dataSource = self
        self.ref = Database.database().reference()
        let currentid = (Auth.auth().currentUser?.uid)!
        
        handlereload = self.ref?.child("users").child(currentid).child("patientDoc").observe(DataEventType.value, with: { (snapshot) in
            allPatients.removeAll()
            
            
            
            for patientdata in snapshot.children.allObjects as![DataSnapshot] {
                let snap = patientdata.value as?[String: String]
                let firstname = snap?["firstname"]
                let lastname = snap?["lastname"]
                let age = snap?["age"]
                let uid = snap?["uid"]
                self.firstName = firstname!
                self.lastName = lastname!
                print("???")
             
                
                let newPatient = Patients()
                newPatient.firstName = firstname!
                newPatient.lastName = lastname!
                newPatient.age = age!
                newPatient.UID = uid!
                
                allPatients.append(newPatient)
             
                self.removehandle()
                self.PatientsTable.reloadData()
                //print(allPatients)
            }
            /*
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell
               {
                   // create a new cell if needed or reuse an old one
                    let cell:UITableViewCell = self.PatientsTable.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier) as UITableViewCell!

                   // gets the text of patient objects
                cell.textLabel?.text = allPatients[indexPath.row].firstName + " " + allPatients[indexPath.row].lastName
                 self.PatientsTable.reloadData()

                      return cell
               }

            */
            
        })
     
    }
    //remove handle
    func removehandle(){
        guard let handle = handlereload else{
            print("i am not remove the handle")
            return
        }
        print("remove the handlereload")
        self.ref?.child("users").removeObserver(withHandle: handle)
        
       
    }
    
    //bool function if users want to sign out
    func gotologsystem(){
        do{
            print("sucessful sign out")
            try Auth.auth().signOut()
            let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: "LoginSystem")
            self.view.window?.rootViewController = loginViewController
            self.view.window?.makeKeyAndVisible()
            
        } catch{
            print("catch error",error)
        }
        
    }
    //sign out function
    @IBAction func signouttapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Warning", message:"Are you sure you want to sign out?", preferredStyle:.alert)
        
        let btnok = UIAlertAction(title: "Sure", style: .default) {(UIAlertAction) -> Void in
            print("Sure")
            
            self.gotologsystem()
        }
        let btncancel = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) -> Void in
            print("cancel")
            
            
        }
        alert.addAction(btnok)
        alert.addAction(btncancel)
        self.present(alert,animated: true,completion: nil)
        
       
        
        
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
        //cell.textLabel?.text = firstName + " " + lastName
        

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
            let physioid = (Auth.auth().currentUser?.uid)!
           
        self.ref?.child("users").child(physioid).child("patientDoc").child(allPatients[indexPath.row].UID).setValue(nil)
            
        
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
        //PatientsTable.reloadData()
        print("HERE")
    }
    
    // If it is the cancel segue, do nothing
    @IBAction func cancel(segue:UIStoryboardSegue) {
      // Do Nothing
      //PatientsTable.reloadData()
        print("HERE2")
    }
    @IBAction func backphysiohomepage(segue:UIStoryboardSegue){
        print("daddy")
    }
    
}
