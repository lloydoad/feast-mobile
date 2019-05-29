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
    
    var backgroundImageView: UIImageView!
    var nameLabel: UILabel!
    var locationLabel: UILabel!
    var tagsLabel: UILabel!
    var deleteButton: UIButton!
    var mapButton: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSelfConstraints()
        self.setupContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSelfConstraints() {
        let spacing: CGFloat = 23
        
        self.selectionStyle = .none
        self.backgroundColor = mainBackground
        
        self.backgroundImageView = UIImageView()
        self.backgroundImageView.clipsToBounds = true
        self.backgroundImageView.layer.cornerRadius = 8
        self.backgroundImageView.layer.borderWidth = 0.8
        self.backgroundImageView.backgroundColor = .clear
        self.backgroundImageView.contentMode = .scaleAspectFill
//        self.backgroundImageView.image = DEFAULT_BACKGROUND_IMAGE
        self.backgroundImageView.layer.borderColor = paleOrange.cgColor
        self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.backgroundImageView)
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -spacing)
        ])
    }
    
    func setupContent() {
        let labelMinimumHeight: CGFloat = 75
        let sideSpacing: CGFloat = 10
        
        let backgroundColorView = UIView()
        backgroundColorView.layer.cornerRadius = 3
        backgroundColorView.layer.borderWidth = 0.8
        backgroundColorView.layer.borderColor = paleOrange.cgColor
        backgroundColorView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColorView.backgroundColor = getColor(red: 255, green: 255, blue: 255, alpha: 0.7)
        
        self.backgroundImageView.addSubview(backgroundColorView)
        NSLayoutConstraint.activate([
            backgroundColorView.heightAnchor.constraint(greaterThanOrEqualToConstant: labelMinimumHeight),
            backgroundColorView.bottomAnchor.constraint(equalTo: self.backgroundImageView.bottomAnchor, constant: -sideSpacing),
            backgroundColorView.leadingAnchor.constraint(equalTo: self.backgroundImageView.leadingAnchor, constant: sideSpacing),
            backgroundColorView.trailingAnchor.constraint(equalTo: self.backgroundImageView.trailingAnchor, constant: -sideSpacing),
        ])
        
        let labelStack = UIStackView()
        labelStack.axis = .vertical
        labelStack.alignment = .fill
        labelStack.distribution = .fill
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
        label.numberOfLines = 0
        label.textColor = color
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }
    
    func setupButtons(bottomView: UIView) {
        self.deleteButton = createButton(name: "trashIcon")
        self.mapButton = createButton(name: "mapIcon")
        
        self.backgroundImageView.addSubview(self.deleteButton)
        self.backgroundImageView.addSubview(self.mapButton)
        
        NSLayoutConstraint.activate([
            self.deleteButton.topAnchor.constraint(equalTo: self.backgroundImageView.topAnchor, constant: 10),
            self.deleteButton.trailingAnchor.constraint(equalTo: self.backgroundImageView.trailingAnchor, constant: -10),
            self.mapButton.topAnchor.constraint(equalTo: self.deleteButton.bottomAnchor, constant: 10),
            self.mapButton.trailingAnchor.constraint(equalTo: self.backgroundImageView.trailingAnchor, constant: -10),
            self.mapButton.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -35)
        ])
    }
    
    func createButton(name: String) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 0.8
        button.layer.borderColor = paleOrange.cgColor
        button.setImage(UIImage(named: name), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.backgroundColor = getColor(red: 255, green: 255, blue: 255, alpha: 0.7)
        return button
    }
}
