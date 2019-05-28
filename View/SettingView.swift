//
//  SettingView.swift
//  Feast
//
//  Created by Lloyd Dapaah on 5/25/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class SettingView: UICollectionViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    static let identifier: String = "SettingViewCellIdentifier"
    
    var questionCount: Int = 4
    var isShowingQuestionCountStack: Bool = false
    var questionCountOptions: [Int] = [3,4,5]
    var mainStack: UIStackView!
    var notificationsSwitch: UISwitch!
    var questionCountButton: CustomButton!
    var suggestionsButton: CustomButton!
    var legalButton: CustomButton!
    var questionCountStack: UIStackView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        let frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        self.frame = frame
        self.setupBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Supported")
    }
    
    func setupBackground() {
        let space: CGFloat = 20
        let contentWidth:CGFloat = frame.width - (2 * space)
        let topOffset: CGFloat = 115
        let buttonHeight: CGFloat = 53
        
        self.backgroundColor = mainBackground
        
        self.mainStack = UIStackView()
        self.mainStack.alignment = .fill
        self.mainStack.distribution = .fill
        self.mainStack.axis = .vertical
        self.mainStack.spacing = 16
        self.mainStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainStack)
        
        NSLayoutConstraint.activate([
            self.mainStack.widthAnchor.constraint(equalToConstant: contentWidth),
            self.mainStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.mainStack.topAnchor.constraint(equalTo: self.topAnchor, constant: topOffset),
            self.mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.setupButtons(stack: mainStack, height: buttonHeight)
        self.mainStack.addArrangedSubview(UIView())
    }
    
    func setupButtons(stack: UIStackView, height: CGFloat) {
        let buttonFrame = CGRect(x: 0, y: 0, width: stack.frame.width, height: height)
        
        self.questionCountButton = addButtonBase(frame: buttonFrame, stack: stack, title: "Number of Questions: \(questionCount)", isEnabled: true)
        self.questionCountButton.addTarget(self, action: #selector(self.respondToQuestionCountButton), for: .touchUpInside)
        
        let notificationsButton = addButtonBase(frame: buttonFrame, stack: stack, title: "Notifications", isEnabled: true)
        notificationsButton.setTitleColor(.white, for: .highlighted)
        self.notificationsSwitch = UISwitch()
        self.notificationsSwitch.onTintColor = paleOrange
        self.notificationsSwitch.tintColor = .white
        self.notificationsSwitch.thumbTintColor = .white
        self.notificationsSwitch.isOn = true
        self.notificationsSwitch.translatesAutoresizingMaskIntoConstraints = false
        notificationsButton.addSubview(self.notificationsSwitch)
        NSLayoutConstraint.activate([
            self.notificationsSwitch.heightAnchor.constraint(lessThanOrEqualToConstant: min(31, buttonFrame.height)),
            self.notificationsSwitch.widthAnchor.constraint(equalToConstant: 60),
            self.notificationsSwitch.trailingAnchor.constraint(equalTo: notificationsButton.trailingAnchor, constant: -notificationsButton.titleEdgeInsets.right),
            self.notificationsSwitch.centerYAnchor.constraint(equalTo: notificationsButton.centerYAnchor)
        ])
        
        self.suggestionsButton = addButtonBase(frame: buttonFrame,stack: stack, title: "Suggestions", isEnabled: true)
        self.legalButton = addButtonBase(frame: buttonFrame, stack: stack, title: "Legal", isEnabled: true)
    }
    
    func addButtonBase(frame: CGRect, stack: UIStackView, title: String, isEnabled: Bool) -> CustomButton{
        let buttonReference = CustomButton(
            frame: frame,
            type: .Light, font:
            headerTwoFont
        )
        buttonReference.customtext = title
        buttonReference.isEnabled = isEnabled
        buttonReference.translatesAutoresizingMaskIntoConstraints = false
        buttonReference.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        stack.addArrangedSubview(buttonReference)
        return buttonReference
    }
    
    @objc func respondToQuestionCountButton() {
        guard !self.isShowingQuestionCountStack else {
            UIView.animate(withDuration: 0.15, animations: {
                self.questionCountStack.alpha = 0
            }) { (_) in
                self.mainStack.removeArrangedSubview(self.questionCountStack)
                self.questionCountStack = nil
                self.isShowingQuestionCountStack = false
            }
            return
        }
        
        self.isShowingQuestionCountStack = true
        self.questionCountStack = UIStackView()
        self.questionCountStack.alpha = 0
        self.questionCountStack.axis = .vertical
        self.questionCountStack.alignment = .fill
        self.questionCountStack.distribution = .fill
        self.questionCountStack.translatesAutoresizingMaskIntoConstraints = false
        self.questionCountStack.heightAnchor.constraint(equalToConstant: 53 + 16 + 82).isActive = true
        
        let infoView = UIView()
        let infoTextLabel = UILabel()
        infoTextLabel.text = "The higher the number of questions, the more accurate, our suggestions can be."
        infoTextLabel.backgroundColor = mainBackground
        infoTextLabel.textAlignment = .left
        infoTextLabel.numberOfLines = 0
        infoTextLabel.textColor = .white
        infoTextLabel.font = infoFont
        infoTextLabel.sizeToFit()
        
        infoTextLabel.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(infoTextLabel)
        NSLayoutConstraint.activate([
            infoTextLabel.topAnchor.constraint(equalTo: infoView.topAnchor),
            infoTextLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 14),
            infoTextLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -14),
            infoTextLabel.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -14)
        ])
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.heightAnchor.constraint(greaterThanOrEqualToConstant: 53).isActive = true
        self.questionCountStack.addArrangedSubview(infoView)
        
        let countPicker = UIPickerView()
        countPicker.dataSource = self
        countPicker.delegate = self
        countPicker.backgroundColor = .clear
        countPicker.showsSelectionIndicator = true
        self.questionCountStack.addArrangedSubview(countPicker)
        countPicker.selectRow(self.questionCount - 3, inComponent: 0, animated: false)
        
        self.mainStack.insertArrangedSubview(self.questionCountStack, at: 1)
        UIView.animate(withDuration: 0.14) {
            self.questionCountStack.alpha = 1
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.questionCountOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = "\(self.questionCountOptions[row])"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.questionCount = row + 3
        self.questionCountButton.customtext = "Number of Questions: \(self.questionCount)"
    }
}
