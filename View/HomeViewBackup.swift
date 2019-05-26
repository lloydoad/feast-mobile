//
//  HomeView.swift
//  Feast
//
//  Created by Lloyd Dapaah on 5/25/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class LayerView: UIView {
    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class HomeViewBackup: UICollectionViewCell {
    static let identifier: String = "HomeViewCellIdentifier"
    
    let topGradientSectionPropotion: CGFloat = 3/7
    let bottomGradientSectionPropotion: CGFloat = 4/7
    let topGradients: [CGFloat] = [0.5, 0.5, 0.25, 0, 0]
    let bottomGradients: [CGFloat] = [0, 0.13, 0.29, 0.46, 0.49, 0.49]
    
    var backgroundImage: UIImageView!
    var topGradientSection: LayerView!
    var bottomGradientSection: LayerView!
    var getDealButton: Button!
    var getOtherRestaurantsButton: Button!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let frame = self.window?.frame ?? frame
        self.frame = frame
        self.backgroundColor = .red
        self.setupBackground()
        self.setupLowerSection()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Supported")
    }
    
    func setupLowerSection() {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 23),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -23),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -53),
            stack.heightAnchor.constraint(equalToConstant: (self.window?.frame.height ?? self.frame.height) * 6/10)
        ])
        
        let width: CGFloat = (self.window?.frame.width ?? self.frame.width) - 40
        let height: CGFloat = 53
        let frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        self.getDealButton = Button(frame: frame, type: .Light, font: headerTwoFont)
//        self.getDealButton.translatesAutoresizingMaskIntoConstraints = false
        self.getDealButton.heightAnchor.constraint(equalToConstant: height).isActive = true
//        self.getDealButton.widthAnchor.constraint(equalTo: stack.widthAnchor, constant: 0).isActive = true
        
        // add to stack
        stack.addSubview(UIView())
        stack.addSubview(self.getDealButton)
    }
    
    func setupBackground() {
        self.backgroundImage = UIImageView(frame: self.frame)
        self.backgroundImage.backgroundColor = .purple
        self.backgroundImage.contentMode = .scaleAspectFill
        self.backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.backgroundImage)
        
        NSLayoutConstraint.activate([
            self.backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.topGradientSection = attachGradientLayer(height: self.topGradientSectionPropotion * self.frame.height, gradients: self.topGradients)
        self.topGradientSection.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        self.bottomGradientSection = attachGradientLayer(height: self.bottomGradientSectionPropotion * self.frame.height, gradients: self.bottomGradients)
        self.bottomGradientSection.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func attachGradientLayer(height: CGFloat, gradients: [CGFloat]) -> LayerView {
        let gradientSection = LayerView()
        gradientSection.backgroundColor = .clear
        gradientSection.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(gradientSection)
        
        NSLayoutConstraint.activate([
            gradientSection.heightAnchor.constraint(equalToConstant: height),
            gradientSection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gradientSection.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        if let gradientLayer = gradientSection.layer as? CAGradientLayer {
            gradientLayer.colors = self.getGradient(gradients: gradients)
        }
        
        return gradientSection
    }
    
    func getGradient(gradients: [CGFloat]) -> [CGColor] {
        var list: [CGColor] = []
        for gradient in gradients {
            list.append(getColor(red: 6, green: 6, blue: 6, alpha: gradient).cgColor)
        }
        return list
    }
    
    func setBackgroundImage(image: UIImage) {
        self.backgroundImage.image = image
    }
}
