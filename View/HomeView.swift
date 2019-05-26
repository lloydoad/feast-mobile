//
//  HomeView.swift
//  Feast
//
//  Created by Lloyd Dapaah on 5/26/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class HomeView: UICollectionViewCell {
    static let reUseIdentifier: String = "HomeViewIdentifier"
    let alphas: [CGFloat] = [0.5, 0.25, 0, 0.25, 0.5, 0.5]
    
    var getDealButton: Button?
    var findOtherButton: Button?
    var dealClassifier: UILabel?
    var dealDescription: UILabel?
    var backgroundImage: UIImageView?
    var constraintFrame: CGRect? {
        didSet {
            initialize(frame: constraintFrame!)
            initializeButtons(frame: constraintFrame!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.constraintFrame = frame
        self.backgroundColor = mainBackground
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLabels(stack: UIStackView, frame: CGRect) {
        let space: CGFloat = 20
        let labelWidth:CGFloat = frame.width - (2 * space)
        let labelHeight: CGFloat = 53
        let frame: CGRect = CGRect(x: 0, y: 0, width: labelWidth, height: labelHeight)
        
        self.dealClassifier = UILabel(frame: frame)
        self.dealClassifier?.text = "KOREAN"
        self.dealClassifier?.numberOfLines = 0
        self.dealClassifier?.sizeToFit()
        self.dealClassifier?.textColor = .white
        self.dealClassifier?.font = headerOneFont
        
        self.dealDescription = UILabel(frame: frame)
        self.dealDescription?.text = "Looking for restaurant deals in your area. Stay tuned!"
        self.dealDescription?.numberOfLines = 0
        self.dealDescription?.sizeToFit()
        self.dealDescription?.textColor = .white
        self.dealDescription?.font = headerThreeFont
        
        stack.addArrangedSubview(self.dealClassifier!)
        stack.addArrangedSubview(self.dealDescription!)
    }
    
    func initializeButtons(frame: CGRect) {
        let bottomOffset: CGFloat = -50
        let space: CGFloat = 20
        let contentWidth:CGFloat = frame.width - (2 * space)
        let contentHeight: CGFloat = frame.height * 6/10
        let buttonHeight: CGFloat = 53
        
        let stack = UIStackView()
        stack.spacing = 16
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.widthAnchor.constraint(equalToConstant: contentWidth),
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stack.heightAnchor.constraint(equalToConstant: contentHeight),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomOffset)
        ])
        
        let upperPlaceHolderView = UIView()
        stack.addArrangedSubview(upperPlaceHolderView)
        
        getDealButton = Button(
            frame: CGRect(x: 0, y: 0, width: frame.width, height: buttonHeight),
            type: .Dark,
            font: headerTwoFont
        )
        findOtherButton = Button(
            frame: CGRect(x: 0, y: 0, width: frame.width, height: buttonHeight),
            type: .Light,
            font: headerTwoFont
        )
        
        getDealButton?.text = "Grab deal"
        getDealButton?.translatesAutoresizingMaskIntoConstraints = false
        getDealButton?.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        findOtherButton?.text = "Find other restaurants"
        findOtherButton?.translatesAutoresizingMaskIntoConstraints = false
        findOtherButton?.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        initializeLabels(stack: stack, frame: frame)
        stack.addArrangedSubview(findOtherButton!)
        stack.addArrangedSubview(getDealButton!)
    }
    
    func initialize(frame: CGRect) {
        self.backgroundImage = UIImageView(frame: frame)
        self.backgroundImage!.contentMode = .scaleAspectFill
        self.backgroundImage!.backgroundColor = .red
        self.backgroundImage!.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.backgroundImage!)
        
        NSLayoutConstraint.activate([
            self.backgroundImage!.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImage!.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundImage!.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImage!.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = []
        self.backgroundImage!.layer.addSublayer(gradientLayer)
        for alpha in alphas {
            let alphaColor = getColor(red: 6, green: 6, blue: 5, alpha: alpha)
            gradientLayer.colors?.append(alphaColor.cgColor)
        }
    }
}
