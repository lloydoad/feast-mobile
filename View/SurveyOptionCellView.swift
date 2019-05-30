//
//  SurveyOptionCellView.swift
//  Feast
//
//  Created by Lloyd Dapaah on 5/29/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class SurveyOptionCellView: UITableViewCell {
    static let reUseIdentifier: String = "DataSummaryCellView"
    let buttonDimension: CGFloat = 44
    let cellSeparators: CGFloat = 23
    
    func setupSelfConstraints() {
        self.selectionStyle = .none
        self.backgroundColor = mainBackground
    }
}
