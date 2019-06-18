//
//  SettingsViewController.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/9/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

extension RootViewController: UIPickerViewDataSource, UIPickerViewDelegate, SettingsViewControllerModelDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return settingsViewControllerModel?.numberOfComponents ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settingsViewControllerModel?.numberOfRowsInComponent ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = settingsViewControllerModel?.getTextFor(row: row) ?? "3"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        settingsViewControllerModel?.setSelectedQuestionOption(row)
    }
    
    func didUpdateSelectedOption(_ value: Int?) {
        guard let option = value else { return }
        let newTitle = "Number of Questions: \(option)"
        settingsView.numberOfQuestionButton.setTitle(newTitle, for: .normal)
        homeViewControllerModel?.setSurveyLimit(option)
    }
    
    @objc func notificationSwitchChanged(_ sender: UISwitch) {
        print(sender.isOn)
    }
    
    @objc func suggestionButtonClicked(_ sender: UIButton) {
        print("open suggestions web")
    }
    
    @objc func legalButtonClicked(_ sender: UIButton) {
        print("open legal web")
    }
    
    @objc func hideOrShowPicker() {
        settingsView.isShowingPicker = !settingsView.isShowingPicker
        let expandedHeight: CGFloat = settingsView.expandedPickerHeight ?? 150.0
        
        if settingsView.isShowingPicker {
            settingsView.numberOfQuestionConstraintHeight.constant = 0
            settingsView.pickerContainerView.alpha = 0
            settingsView.mainStackView.insertArrangedSubview(settingsView.pickerContainerView, at: 1)
            
            UIView.animate(withDuration: 0.5) {
                self.settingsView.pickerContainerView.alpha = 1
                self.settingsView.numberOfQuestionConstraintHeight.constant = expandedHeight
            }
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                self.settingsView.pickerContainerView.alpha = 0
            }) { (_) in
               self.settingsView.numberOfQuestionConstraintHeight.constant = 0
                self.settingsView.mainStackView.removeArrangedSubview(self.settingsView.pickerContainerView)
            }
        }
    }
}
