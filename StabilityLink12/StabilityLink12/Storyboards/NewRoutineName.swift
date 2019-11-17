//
//  NewRoutineName.swift
//  StabilityLink12
//
//  Created by Daimon Gill on 2019-11-17.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
var currentRoutine = ""
class NewRoutineName: UIViewController {

    
    @IBOutlet weak var routineName: UITextField!
    
    @IBOutlet weak var errorlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        routineName.placeholder = "Enter New Routine Name"
        errorlabel.alpha = 0
        // Do any additional setup after loading the view.
    }
    func validateFields() -> String? {
        if(routineName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "")
        {
            return "please enter routine name and save it"
        }
        return nil
    }
    
    func transitiontoexercise() {
        currentRoutine = routineName.text!
        print("i ma here", currentRoutine)
        let Homepagecontroller = storyboard?.instantiateViewController(withIdentifier: "ExercisePage") as? ExerciseNameList
        
        view.window?.rootViewController = Homepagecontroller
        view.window?.makeKeyAndVisible()
        
    }
    func showError(_ message:String)
       {
           errorlabel.text = message
           errorlabel.alpha = 1
          
       }

    @IBAction func Savetapped(_ sender: Any) {
        let error = validateFields()
               if error != nil{
                   showError(error!)
               }
               else{
                   self.transitiontoexercise()
               }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
