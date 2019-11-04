//
//  CheckBox.swift
//  StabilityLink12
//
//  Created by Matthew Chute on 2019-11-03.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    let checkedImg = UIImage(named: "checked")! as UIImage
    let uncheckedImg = UIImage(named: "unchecked")! as UIImage

    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImg, for: UIControl.State.normal)
            }
            else {
                self.setImage(uncheckedImg, for: UIControl.State.normal)
            }
        }
    }

    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }

    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }

}
