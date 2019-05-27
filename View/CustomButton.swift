//
//  CustomButton.swift
//  Feast
//
//  Created by Lloyd Dapaah on 5/27/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

enum CustomButtonType {
    case Dark
    case Light
}

class CustomButton: UIButton {
    
    var customType: CustomButtonType!
    var customFont: UIFont = headerTwoFont
    var customTextColor: UIColor = .white
    
    override var buttonType: UIButton.ButtonType {
        return .system
    }
    var customtext: String = "" {
        didSet {
            self.setAttributedTitle(
                NSAttributedString(
                    string: customtext,
                    attributes: [
                        NSAttributedString.Key.foregroundColor: self.customTextColor,
                        NSAttributedString.Key.font: self.customFont
                    ]
                ),
                for: UIControl.State.normal
            )
        }
    }
    
    init(frame: CGRect, type: CustomButtonType, font: UIFont) {
        super.init(frame: frame)
        self.customType = type
        self.customFont = font
        self.initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 0.13
        self.layer.shadowRadius = 0.25
        self.contentHorizontalAlignment = .left
        self.layer.shadowOffset = CGSize(width: 0.12, height: 0.12)
        self.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.backgroundColor = lightDark
        
        if customType! == CustomButtonType.Dark {
            self.layer.borderColor = paleOrange.cgColor
            self.layer.shadowColor = white.cgColor
            self.customTextColor = paleOrange
        } else {
            self.layer.borderColor = white.cgColor
            self.layer.shadowColor = paleOrange.cgColor
            self.customTextColor = white
        }
    }
}
