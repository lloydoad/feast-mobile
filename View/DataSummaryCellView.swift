//
//  DataSummaryCellView.swift
//  Feast
//
//  Created by Lloyd Dapaah on 5/28/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class DataSummaryCellView: UITableViewCell {
    static let reUseIdentifier: String = "DataSummaryCellView"
    let buttonLabelInterSpace: CGFloat = 35
    let buttonDimension: CGFloat = 44
    let cellSeparators: CGFloat = 23
    let sideSpacing: CGFloat = 10
    
    var customBackgroundView: UIView!
    var nameLabel: UILabel!
    var locationLabel: UILabel!
    var tagsLabel: UILabel!
    var deleteButton: UIButton!
    var mapButton: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSelfConstraints()
        self.setupContent()
        self.setupImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSelfConstraints() {
        self.selectionStyle = .none
        self.backgroundColor = mainBackground
        
        self.customBackgroundView = UIView()
        self.customBackgroundView.clipsToBounds = true
        self.customBackgroundView.layer.cornerRadius = 8
        self.customBackgroundView.layer.borderWidth = 0.8
        self.customBackgroundView.backgroundColor = .clear
        self.customBackgroundView.layer.borderColor = paleOrange.cgColor
        self.customBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.customBackgroundView)
        NSLayoutConstraint.activate([
            self.customBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            self.customBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.customBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.customBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.cellSeparators)
        ])
    }
    
    func setupContent() {
        let labelMinimumHeight: CGFloat = 70
        
        let backgroundColorView = UIView()
        backgroundColorView.layer.cornerRadius = 3
        backgroundColorView.layer.borderWidth = 0.8
        backgroundColorView.layer.borderColor = paleOrange.cgColor
        backgroundColorView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColorView.backgroundColor = getColor(red: 255, green: 255, blue: 255, alpha: 0.83)
        
        self.customBackgroundView.addSubview(backgroundColorView)
        NSLayoutConstraint.activate([
            backgroundColorView.heightAnchor.constraint(greaterThanOrEqualToConstant: labelMinimumHeight),
            backgroundColorView.bottomAnchor.constraint(equalTo: self.customBackgroundView.bottomAnchor, constant: -self.sideSpacing),
            backgroundColorView.leadingAnchor.constraint(equalTo: self.customBackgroundView.leadingAnchor, constant: self.sideSpacing),
            backgroundColorView.trailingAnchor.constraint(equalTo: self.customBackgroundView.trailingAnchor, constant: -self.sideSpacing),
        ])
        
        let labelStack = UIStackView()
        labelStack.spacing = 2
        labelStack.axis = .vertical
        labelStack.alignment = .fill
        labelStack.distribution = .equalCentering
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColorView.addSubview(labelStack)
        NSLayoutConstraint.activate([
            labelStack.topAnchor.constraint(equalTo: backgroundColorView.topAnchor, constant: 5),
            labelStack.bottomAnchor.constraint(equalTo: backgroundColorView.bottomAnchor, constant: -5),
            labelStack.leadingAnchor.constraint(equalTo: backgroundColorView.leadingAnchor, constant: 5),
            labelStack.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -5),
        ])
        
        self.nameLabel = createLabel(title: "Restaurant Title", font: headerTwoFont, color: .black)
        self.tagsLabel = createLabel(title: "Tag 1, Tag 2, Tag 3", font: headerThreeFont, color: red)
        self.locationLabel = createLabel(title: "Location Details, Location Details, Location Details", font: headerThreeFont, color: red)
        
        labelStack.addArrangedSubview(self.nameLabel)
        labelStack.addArrangedSubview(self.tagsLabel)
        labelStack.addArrangedSubview(self.locationLabel)
        
        setupButtons(bottomView: backgroundColorView)
    }
    
    func createLabel(title: String, font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = font
        label.sizeToFit()
        label.numberOfLines = 0
        label.textColor = color
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }
    
    func setupButtons(bottomView: UIView) {
        self.deleteButton = createButton(name: "trashIcon")
        self.mapButton = createButton(name: "mapIcon")
        
        self.customBackgroundView.addSubview(self.deleteButton)
        self.customBackgroundView.addSubview(self.mapButton)
        
        NSLayoutConstraint.activate([
            self.deleteButton.topAnchor.constraint(equalTo: self.customBackgroundView.topAnchor, constant: self.sideSpacing),
            self.deleteButton.trailingAnchor.constraint(equalTo: self.customBackgroundView.trailingAnchor, constant: -self.sideSpacing),
            self.mapButton.topAnchor.constraint(equalTo: self.deleteButton.bottomAnchor, constant: self.sideSpacing),
            self.mapButton.trailingAnchor.constraint(equalTo: self.customBackgroundView.trailingAnchor, constant: -self.sideSpacing),
            self.mapButton.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -self.buttonLabelInterSpace)
        ])
    }
    
    func createButton(name: String) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 0.8
        button.layer.borderColor = paleOrange.cgColor
        button.setImage(UIImage(named: name), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.backgroundColor = getColor(red: 255, green: 255, blue: 255, alpha: 0.83)
        button.widthAnchor.constraint(equalToConstant: self.buttonDimension).isActive = true
        button.heightAnchor.constraint(equalToConstant: self.buttonDimension).isActive = true
        return button
    }
    
    func setupImage() {
        let backgroundImage = UIImageView()
        backgroundImage.clipsToBounds = true
        backgroundImage.backgroundColor = .clear
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = DEFAULT_BACKGROUND_IMAGE
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.customBackgroundView.insertSubview(backgroundImage, at: 0)
        NSLayoutConstraint.activate([
            backgroundImage.heightAnchor.constraint(equalToConstant: 650),
            backgroundImage.widthAnchor.constraint(equalTo: self.customBackgroundView.widthAnchor),
            backgroundImage.centerXAnchor.constraint(equalTo: self.customBackgroundView.centerXAnchor),
            backgroundImage.centerYAnchor.constraint(equalTo: self.customBackgroundView.centerYAnchor)
        ])
    }
}
