//
//  SLLabel.swift
//  StabilityLink12
//
//  Created by Alex Makasoff on 2019-11-26.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit

class SLLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpField()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init( coder: aDecoder )
        setUpField()
    }
    
    
    private func setUpField() {
        tintColor             = .white
        textColor             = .darkGray
        font                  = UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 18)
        backgroundColor       = UIColor(white: 1.0, alpha: 0.5)
        layer.cornerRadius    = 25.0
        clipsToBounds         = true
    }
}
