//
//  Button.swift
//  Feast
//
//  Created by Lloyd Dapaah on 5/26/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

enum ButtonCustomType {
    case Dark
    case Light
}

class Button: LoadableButton {
    var color: UIColor!
    var label: UILabel!
    var customtype: ButtonCustomType!
    var blur: UIVisualEffectView!
    var text: String = "" {
        didSet {
            if self.label != nil {
                self.label.text = self.text
            }
        }
    }
    
    override var buttonType: UIButton.ButtonType {
        return .system
    }
    
    init(frame: CGRect, type: ButtonCustomType, font: UIFont) {
        super.init(frame: frame)
        self.customtype = type
        self.setupLayers()
        self.setupLabel(font: font)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayers() {
        self.layer.borderWidth = 0.6
        self.layer.cornerRadius = 8
        self.backgroundColor = .clear
        self.color = self.customtype == ButtonCustomType.Dark ? paleOrange : white
        self.layer.borderColor = self.color.cgColor
        
        self.blur = UIVisualEffectView(frame: self.frame)
        let blurEffect = self.customtype == ButtonCustomType.Dark ? UIBlurEffect(style: .dark) : UIBlurEffect(style: .prominent)
        self.blur.effect = UIVibrancyEffect(blurEffect: blurEffect)
        self.addSubview(self.blur)
    }
    
    func setupLabel(font: UIFont) {
        self.label = UILabel()
        self.label.font = font
        self.label.text = self.text
        self.label.textColor = self.color
        self.label.textAlignment = .left
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.label)
        
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    func updateBlurFrame() {
        self.blur.frame = self.frame
    }
}
