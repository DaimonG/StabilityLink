//
//  HomePage.swift
//  StabilityLink12
//
//  Created by BinXiong on 2019/11/10.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit

class HomePage: UIViewController {

    @IBOutlet weak var signupbutton: UIButton!
    @IBOutlet weak var loginbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // setupelements()
        
    }
    
    func setupelements(){
        Utilities.styleFilledButton(signupbutton)
        Utilities.styleHollowButton(loginbutton)
    }
    
}
