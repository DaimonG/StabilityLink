//
//  StartExercise.swift
//  StabilityLink12
//
//  Created by Bin Xiong on 11/3/19.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit

class StartExercise: UIViewController {
    
    @IBOutlet weak var repsnumber: UILabel!
    @IBOutlet weak var setnumber: UILabel!
    @IBOutlet weak var Despart: UILabel!
    @IBOutlet weak var Imagepart: UIImageView!
    var StartExerciseList : ExerciseListTable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repsnumber.text = StartExerciseList?.reps
        setnumber.text = StartExerciseList?.sets
        Despart.text = StartExerciseList?.describution
        
        Imagepart.image = UIImage(named: (StartExerciseList!.name + ".png"))
        
        
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
