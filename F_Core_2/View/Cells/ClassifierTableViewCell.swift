//
//  ClassiffierTableViewCell.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/14/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class ClassifierTableViewCell: UITableViewCell {
    public static let identifier: String = "ClassifierTableViewCell"
    @IBOutlet weak var contentButton: ThemeUIButton!
    
    var classifierModel: Classifier? {
        didSet {
            contentButton.setTitle(classifierModel?.name, for: .normal)
        }
    }
    
    var restaurantModel: Restaurant? {
        didSet {
            contentButton.setTitle(restaurantModel?.reviews.first?.text, for: .normal)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
