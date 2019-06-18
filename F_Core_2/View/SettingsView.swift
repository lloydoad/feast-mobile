//
//  SettingsView.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/8/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var numberOfQuestionButton: ThemeUIButton!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var suggestionsButton: ThemeUIButton!
    @IBOutlet weak var legalButton: ThemeUIButton!
    @IBOutlet weak var numberOfQuestionPicker: UIPickerView!
    @IBOutlet weak var numberOfQuestionConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var pickerContainerView: UIStackView!
    @IBOutlet weak var mainStackView: UIStackView!
    
    var expandedPickerHeight: CGFloat?
    var isShowingPicker: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initView()
    }
    
    private func initView() {
        Bundle.main.loadNibNamed("SettingsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        expandedPickerHeight = numberOfQuestionConstraintHeight.constant
    }
}
