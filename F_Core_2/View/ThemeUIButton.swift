//
//  ThemeButton.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/8/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

@IBDesignable
class ThemeUIButton: UIButton {
    var labelToButtonConstraint: NSLayoutConstraint?
    
    @IBInspectable var mainColor: UIColor = paleOrange {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var secondaryColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    var hasAdjustableHeight: Bool = false {
        didSet {
            labelToButtonConstraint?.isActive = hasAdjustableHeight
        }
    }
    
    func updateSelfConstraints() {
        self.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.labelToButtonConstraint = self.titleLabel?.heightAnchor.constraint(equalTo: self.heightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateSelfConstraints()
    }
    
    func updateView() {
        self.layer.shadowOpacity = 1
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 0.13
        self.layer.shadowRadius = 0.7
        self.layer.borderColor = mainColor.cgColor
        self.layer.shadowColor = secondaryColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0.12, height: 0.12)
        
        self.setTitleColor(mainColor, for: .normal)
        self.setTitleColor(paleWhiteRed, for: .highlighted)
    }
}
