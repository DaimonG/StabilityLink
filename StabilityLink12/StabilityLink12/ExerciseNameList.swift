//
//  ExerciseNameList.swift
//  StabilityLink12
//
//  Created by Bin Xiong on 2019-11-03.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
var Description=["ArmRaise","ShoulderSqueeze","CalfRaise","LegRaise","KneeBend"]
var nameofexercise=["ArmRaise","ShoulderSqueeze","CalfRaise","LegRaise","KneeBend"]
var ExerciseIndex=0

class ExerciseNameList: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameofexercise.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ExerciseList", for: indexPath)
        let dessert = nameofexercise[indexPath.row]
        cell.textLabel?.text = dessert
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        ExerciseIndex = indexPath.row
        performSegue(withIdentifier: "ExerciseMain", sender: self)
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
