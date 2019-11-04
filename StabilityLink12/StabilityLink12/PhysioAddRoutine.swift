//
//  PhysioAddRoutine.swift
//  StabilityLink12
//
//  Created by Bin Xiong on 2019-11-03.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit

class PhysioAddRoutine: UIViewController {

    var Routines:String = ""
  
    
    // Linking 3 Text Fields
    
    @IBOutlet weak var RoutineName: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    // Load Screen Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            
        }
    }
    
    // Hide Keyboard Function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
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
