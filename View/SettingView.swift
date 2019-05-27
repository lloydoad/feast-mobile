//
//  SettingView.swift
//  Feast
//
//  Created by Lloyd Dapaah on 5/25/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class SettingView: UICollectionViewCell {
    static let identifier: String = "SettingViewCellIdentifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Supported")
    }
    
    func setupBackground() {
        self.backgroundColor = mainBackground
    }
}
