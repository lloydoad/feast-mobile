//
//  SettingsViewControllerModel.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/9/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import Foundation

protocol SettingsViewControllerModelDelegate {
    func didUpdateSelectedOption(_ value: Int?) -> Void
}

struct SettingsViewControllerModel {
    var delegate: SettingsViewControllerModelDelegate?
    
    private(set) var numberOfComponents: Int = 1
    private(set) var numberOfRowsInComponent: Int = 3
    
    private var selectedQuestionOptionIndex: Int = 1 {
        didSet {
            guard let row = getSelectedOptionIndex() else { return }
            let value = getValueFor(row: row)
            delegate?.didUpdateSelectedOption(value)
        }
    }
    
    private(set) var availableOptions: [Int] = [3, 4, 5] {
        didSet {
            self.numberOfRowsInComponent = availableOptions.count
        }
    }
    
    init(delegate: SettingsViewControllerModelDelegate) {
        self.delegate = delegate
        
        defer {
            self.selectedQuestionOptionIndex = Defaults.getNumberOfQuestionsIndex().numberOfQuestionSettings
        }
    }
    
    mutating func updateOptions(options: [Int]) {
        self.availableOptions = options
    }
    
    mutating func setSelectedQuestionOption(_ index: Int) {
        self.selectedQuestionOptionIndex = index
        Defaults.save(getValueFor(row: index))
    }
    
    func getSelectedOptionIndex() -> Int? {
        if selectedQuestionOptionIndex >= 0 && selectedQuestionOptionIndex <= availableOptions.count { return selectedQuestionOptionIndex }
        return nil
    }
    
    func getValueFor(row: Int) -> Int {
        if row >= 0 && row < availableOptions.count { return availableOptions[row] }
        return 3
    }
    
    func getTextFor(row: Int) -> String {
        return "\(getValueFor(row: row))"
    }
}
