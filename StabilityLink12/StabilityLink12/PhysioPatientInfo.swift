//
//  PhysioPatientInfo.swift
//  StabilityLink12
//
//  Created by Bin Xiong on 2019-11-2.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//
import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import AVKit
import AVFoundation
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

var allPatientRoutines:[Routines] = []

var selectedRoutine = ""

class PhysioPatientInfo: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    let avPlayerViewController = AVPlayerViewController()
    var avPlayer:AVPlayer?
    
    var TemExerciseArray:[TempExerciseListTable] = []
    // Connecting UI Elements
    @IBOutlet weak var PatientFirstName: UILabel!
    
    @IBOutlet weak var PatientLastName: UILabel!
    
    @IBOutlet weak var PatientAge: UILabel!
    
    
    @IBOutlet weak var errorlable: UILabel!
    @IBOutlet weak var RoutinesTable: UITableView!
    
    @IBOutlet weak var VideoButton: SLButton!
    
    var totalRoutines = 0
    
    var patientRoutines:[Routines]? = []
    var patientKeys:[String] = []
    var routinesname:[String] = []
    
    
    // Patient Object that is optional
    var tPatient: Patients?
    var ref:DatabaseReference?
    var handle1:DatabaseHandle?
    
 
    
    override func viewDidLoad() {
        errorlable.alpha = 0
        super.viewDidLoad()
        PatientFirstName.text = tPatient?.firstName
        PatientLastName.text = tPatient?.lastName
        PatientAge.text = tPatient?.age
        currentPatient = (tPatient?.UID)!
        
        VideoButton.setTitle("Video", for: .normal)
        //patientRoutines = tPatient?.routines
        
        // Video Player URL
        let movieURL:NSURL? = NSURL(string: "gs://cmpt275-6fc69.appspot.com/" + "\(currentPatient)" + ".mov")
        
        if let url = movieURL {
            self.avPlayer = AVPlayer(url: url as URL)
            self.avPlayerViewController.player = self.avPlayer
            
        }
        
        self.RoutinesTable.register(UITableViewCell.self, forCellReuseIdentifier: "RoutineCell")
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        self.RoutinesTable.tableFooterView = UIView()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        RoutinesTable.delegate = self
        RoutinesTable.dataSource = self
        // Do any additional setup after loading the view.
        
        self.ref = Database.database().reference()
            allPatientRoutines.removeAll()
         self.ref?.child("users").child(currentPatient).child("routines").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
          
            print("aaaaaaaaaaa")
            if let data = snapshot.value as? [String: Any]{
                

                   
                self.patientKeys = Array(data.keys)
                print(self.patientKeys)
                    
                for x in self.patientKeys{
                    let routinename = Routines()
                    routinename.name = x
                    print("\n", routinename.name)
                    allPatientRoutines.append(routinename)
                    self.RoutinesTable.reloadData()
                }
                self.removehandle()
                    
            }
                
               
                
               
                
            
            
        })
        
    }
    func removehandle(){
        guard  let handle = handle1 else {
            return
        }
        self.ref?.child("users").removeObserver(withHandle: handle)
    }
    

    
    func removepatient(){
       
        let physioid = (Auth.auth().currentUser?.uid)!
       
        self.ref?.child("users").child(physioid).child("patientDoc").child(currentPatient).removeValue()
        
       
    
        let loginStoryboard = UIStoryboard(name: "physioHome", bundle: nil)
        let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: "PhysicalTherapistHome")
        self.view.window?.rootViewController = loginViewController
        self.view.window?.makeKeyAndVisible()
     
      
    
            
        
    }
    
    //check again if the patient already be removed
  
    
    ///Remove Patient Function
    @IBAction func removetapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Warning", message:"Are you sure you want to remove this patient?", preferredStyle:.alert)
        
        let btnok = UIAlertAction(title: "Sure", style: .default) {(UIAlertAction) -> Void in
           
            
            self.removepatient()
        }
        let btncancel = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) -> Void in
           
            
            
        }
        alert.addAction(btnok)
        alert.addAction(btncancel)
        self.present(alert,animated: true,completion: nil)
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
        
        return allPatientRoutines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"RoutineCell", for: indexPath)
        
        cell.textLabel?.text = allPatientRoutines[indexPath.row].name
        return cell
        
    }
   
  
    
    /*
     * When the cell is tapped
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectedRoutine = allPatientRoutines[indexPath.row].name
        self.performSegue(withIdentifier: "ToRoutineInformation", sender: nil)
        
    }
    
    @IBAction func backphysio(segue:UIStoryboardSegue){
        print("daddy")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    /*
     * Delete Table Cell Function
     */
    
    //delete routines
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:IndexPath )
    {
        
        
        if editingStyle == .delete{
        
           
            
             ref?.child("users").child(currentPatient).child("routines").child(allPatientRoutines[indexPath.row].name).removeValue(completionBlock: { (error, ref) in
                    if error != nil{
                        print("Failed to delete routines",error as Any)
                        return
                    }
              
                
    
                else{
                    allPatientRoutines.remove(at: indexPath.row)
                    
                    tableView.beginUpdates()
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    tableView.endUpdates()
                }
                    
                    
                    
                    
                    
                })
            
        /*
         if editingStyle == .delete{
            RoutinesArray.remove(at: indexPath.row)
        print("indexpathrow",indexPath.row)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
       */
        
            
            
            
            
 
 
        }
    }
    
    
    @IBAction func PlayButtonPressed(_ sender: UIButton) {
        
        // Trigger the video to play
        /*
         
        self.present(self.avPlayerViewController, animated: true) {
            () -> Void in
            self.avPlayerViewController.player?.play()
        }*/
        let storageRef = Storage.storage().reference()
        let pathReference = storageRef.child(("\(currentPatient)" + ".mov"))
        
        pathReference.downloadURL { (URL, error) in
            if(error != nil)
            {
                
                self.errorlable.alpha = 1
                self.errorlable.text = "No Video Uploaded!"
                return
            }
            else{
                if let getURL = URL {
                    let player = AVPlayer(url : getURL)
                    let controller = AVPlayerViewController()
                    controller.player = player
                    controller.view.frame = self.view.frame
                    self.view.addSubview(controller.view)
                    self.addChild(controller)
                    player.play()
                }
               
                
            }
        }
        
    }
}
