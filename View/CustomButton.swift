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
    override var buttonType: UIButton.ButtonType {
        return .system
    }
    
    var customType: CustomButtonType = .Dark
    var customFont: UIFont = headerTwoFont
    var mainColor: UIColor = .white
    var secondaryColor: UIColor = paleOrange
    var customtext: String = "" {
        didSet {
            self.setTitle(self.customtext, for: .normal)
        }
    }
    
    init(frame: CGRect, type: CustomButtonType, font: UIFont) {
        super.init(frame: frame)
        self.customType = type
        self.customFont = font
        self.mainColor = self.customType == .Dark ? paleOrange : .white
        self.secondaryColor = self.customType == .Dark ? .white : paleOrange
        self.initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 0.13
        self.layer.shadowRadius = 0.7
        self.layer.borderColor = mainColor.cgColor
        self.layer.shadowColor = secondaryColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0.12, height: 0.12)
        self.layer.shadowOpacity = 1
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        self.backgroundColor = lightDark
        self.contentHorizontalAlignment = .left
        self.titleLabel?.font = self.customFont
        self.setTitleColor(mainColor, for: .normal)
        self.setTitleColor(paleWhiteRed, for: .highlighted)
        self.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
