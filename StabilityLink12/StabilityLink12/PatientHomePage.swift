//
//  PatientHomePage.swift
//  StabilityLink12
//
//  Created by BinXiong on 2019/11/22.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
import Firebase


class PatientHomePage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
