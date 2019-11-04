//
//  CheckBox.swift
//  StabilityLink12
//
//  Created by Matthew Chute on 2019-11-03.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    //Checked CheckBox Image
    let checkedImg = UIImage(named: "checked")! as UIImage
    
    //Unchecked CheckBox Image
    let uncheckedImg = UIImage(named: "unchecked")! as UIImage

    //Bool for if CheckBox has been checked
    var checked: Bool = false {
        didSet {
            
            //If the CheckBox IS NOT checked, set image of button to uncheckedImg
            if checked == false {
                self.setImage(uncheckedImg, for: UIControl.State.normal)
            }
                
            //Else, the CheckBox IS checked, set image of button to checkedImg
            else {
                self.setImage(checkedImg, for: UIControl.State.normal)
            }
        }
    }

    //Initialize checked value to false (CheckBox starts unchecked)
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(boxChecked), for: UIControl.Event.touchUpInside)
        self.checked = false
    }

    //Switch Bool value once box is checked
    @objc func boxChecked(sender: UIButton) {
        if sender == self {
            checked = !checked
        }
    }
}
