//
//  TempExerciseDetail.swift
//  StabilityLink12
//
//  Created by Bin Xiong on 11/4/19.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit

class TempExerciseDetail: UIViewController {

    @IBOutlet weak var repsnumber: UILabel!
    @IBOutlet weak var setnumber: UILabel!
    @IBOutlet weak var Despart: UIImageView!
    @IBOutlet weak var Imagepart: UIImageView!
    var StartExerciseList : ExerciseListTable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repsnumber.text = temReps[check_index]
        setnumber.text = TemSets[check_index]
    
        
        Imagepart.image = UIImage(named: (TemName[check_index] + ".png"))
        Despart.image = UIImage(named: (TemDescribution[check_index] + ".png"))
       
        
        // Do any additional setup after loading the view.
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
