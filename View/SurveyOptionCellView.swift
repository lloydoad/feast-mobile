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
    let buttonDimension: CGFloat = 44
    let cellSeparators: CGFloat = 23
    
    var contentBackground: UIView!
    var titleView: UILabel!
    var title: String = "" {
        didSet {
            if self.titleView != nil {
                self.titleView.text = self.title
            }
        }
    }
    
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
        
        self.contentBackground = UIView()
        self.contentBackground.layer.cornerRadius = 8
        self.contentBackground.layer.shadowOpacity = 1
        self.contentBackground.layer.borderWidth = 0.13
        self.contentBackground.layer.shadowRadius = 0.7
        self.contentBackground.backgroundColor = lightDark
        self.contentBackground.layer.borderColor = paleOrange.cgColor
        self.contentBackground.layer.shadowColor = UIColor.white.cgColor
        self.contentBackground.layer.shadowOffset = CGSize(width: 0.12, height: 0.12)
        self.contentBackground.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleView = UILabel()
        self.titleView.numberOfLines = 0
        self.titleView.textColor = .white
        self.titleView.font = headerThreeFont
        self.titleView.backgroundColor = .clear
        self.titleView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.contentBackground)
        self.contentBackground.addSubview(self.titleView)
        
        NSLayoutConstraint.activate([
            self.contentBackground.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.contentBackground.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.contentBackground.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.contentBackground.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -cellSeparators),
            
            self.titleView.topAnchor.constraint(equalTo: self.contentBackground.topAnchor, constant: 10),
            self.titleView.leadingAnchor.constraint(equalTo: self.contentBackground.leadingAnchor, constant: 10),
            self.titleView.trailingAnchor.constraint(equalTo: self.contentBackground.trailingAnchor, constant: -10),
            self.titleView.bottomAnchor.constraint(equalTo: self.contentBackground.bottomAnchor, constant: -10)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        print("selected")
        self.backgroundColor = .black
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.backgroundColor = .black
    }
}
