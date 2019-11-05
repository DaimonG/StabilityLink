
//
//  ExerciseList.swift
//  StabilityLink12
//
//  Created by Bin Xiong on 11/2/19.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit

class ExerciseList: UIViewController {
    var stringSetNumber = "0"
    var stringRepsNumber = "0"
    var setnumber = 0
    var repsnumber = 0
    var name = nameofexercise[ExerciseIndex]
    var Des = Description[ExerciseIndex]
    
    var nextexerciseindex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        ExerciseImage.image = UIImage(named: (nameofexercise[ExerciseIndex] + ".png") )
        ExerciseDescribution.image = UIImage(named: (Description[ExerciseIndex] + ".png") )
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "ToExercise", sender: self)
        
    }
    
    @IBOutlet weak var ExerciseImage: UIImageView!
    @IBOutlet weak var ExerciseDescribution: UIImageView!
    
    @IBOutlet weak var ExerciseSetNumber: UILabel!
    @IBOutlet weak var ExerciseReps: UILabel!
    @IBAction func SetMinus(_ sender: Any) {
        if setnumber==0{
            ExerciseSetNumber.text = String(0)
            setnumber = 0
        }
        else{
            setnumber = setnumber - 1
            ExerciseSetNumber.text = String(setnumber)
        }
        stringSetNumber = String(setnumber)
    }
    @IBAction func SetsPlus(_ sender: Any) {
        setnumber = setnumber + 1
        ExerciseSetNumber.text = String(setnumber)
        stringSetNumber = String(setnumber)
        
    }
    @IBAction func RepsMinus(_ sender: Any) {
        if repsnumber==0{
            ExerciseReps.text = String(repsnumber)
            repsnumber = 0
            
            
        }
        else{
            repsnumber = repsnumber - 1
            ExerciseReps.text = String(repsnumber)
        }
        stringRepsNumber = String(repsnumber)
    }
    @IBAction func RepsPlus(_ sender: Any) {
        
        
        repsnumber = repsnumber + 1
        ExerciseReps.text = String(repsnumber)
        stringRepsNumber = String(repsnumber)
        
    }
    
    
    // MARK: - Table view data source
    
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
