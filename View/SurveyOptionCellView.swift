//
//  SurveyOptionCellView.swift
//  Feast
//
//  Created by Lloyd Dapaah on 5/29/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class SurveyOptionCellView: UITableViewCell {
    static let reUseIdentifier: String = "SurveyOptionCellView"
    let cellSeparators: CGFloat = 23
    
    var contentButton: CustomButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSelfConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSelfConstraints() {
        self.selectionStyle = .none
        self.backgroundColor = mainBackground
        
        self.contentButton = CustomButton(frame: self.frame, type: .Light, font: headerThreeFont)
        self.contentButton.setTitle("Yeet?", for: .normal)
        self.contentButton.titleLabel?.numberOfLines = 0
        self.contentButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.contentButton)
        
        NSLayoutConstraint.activate([
            self.contentButton.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.contentButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.contentButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.contentButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -cellSeparators)
        ])
        
        if let heightAnchor = self.contentButton.titleLabel?.heightAnchor {
            self.contentButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        } else {
            assertionFailure("Failed to anchor title label to button")
        }
    }
}
