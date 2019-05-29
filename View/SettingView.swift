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
    
    var questionAmount: Int = 4
    var questionAmountOptions: [Int] = [3,4,5]
    var isShowingQuestionAmountView: Bool = false
    
    var mainButtonStack: UIStackView!
    var notificationsSwitch: UISwitch!
    var questionAmountPickerStack: UIStackView!
    var legalButton: CustomButton!
    var suggestionsButton: CustomButton!
    var questionCountButton: CustomButton!

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
        let topOffset: CGFloat = 115
        let buttonHeight: CGFloat = 53
        let contentWidth:CGFloat = frame.width - (2 * space)
        
        self.mainButtonStack = UIStackView()
        self.mainButtonStack.alignment = .fill
        self.mainButtonStack.distribution = .fill
        self.mainButtonStack.axis = .vertical
        self.mainButtonStack.spacing = 16
        self.mainButtonStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainButtonStack)
        
        NSLayoutConstraint.activate([
            self.mainButtonStack.widthAnchor.constraint(equalToConstant: contentWidth),
            self.mainButtonStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.mainButtonStack.topAnchor.constraint(equalTo: self.topAnchor, constant: topOffset),
            self.mainButtonStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.setupButtons(stack: mainButtonStack, height: buttonHeight)
        self.mainButtonStack.addArrangedSubview(UIView())
    }
    
    func setupButtons(stack: UIStackView, height: CGFloat) {
        let buttonFrame = CGRect(x: 0, y: 0, width: stack.frame.width, height: height)
        
        self.questionCountButton = addButtonBase(frame: buttonFrame, stack: stack, title: "Number of Questions: \(questionAmount)", isEnabled: true)
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
        guard !self.isShowingQuestionAmountView else {
            UIView.animate(withDuration: 0.15, animations: {
                self.questionAmountPickerStack.alpha = 0
            }) { (_) in
                self.mainButtonStack.removeArrangedSubview(self.questionAmountPickerStack)
                self.isShowingQuestionAmountView = false
                self.questionAmountPickerStack = nil
            }
            return
        }
        
        self.isShowingQuestionAmountView = true
        self.questionAmountPickerStack = UIStackView()
        self.questionAmountPickerStack.alpha = 0
        self.questionAmountPickerStack.axis = .vertical
        self.questionAmountPickerStack.alignment = .fill
        self.questionAmountPickerStack.distribution = .fill
        self.questionAmountPickerStack.translatesAutoresizingMaskIntoConstraints = false
        self.questionAmountPickerStack.heightAnchor.constraint(equalToConstant: 53 + 16 + 82).isActive = true
        
        let infoView = UIView()
        let infoViewText = UILabel()
        infoViewText.text = "The higher the number of questions, the more accurate, our suggestions can be."
        infoViewText.sizeToFit()
        infoViewText.font = infoFont
        infoViewText.numberOfLines = 0
        infoViewText.textColor = .white
        infoViewText.textAlignment = .left
        infoViewText.backgroundColor = mainBackground
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.heightAnchor.constraint(greaterThanOrEqualToConstant: 53).isActive = true
        self.questionAmountPickerStack.addArrangedSubview(infoView)
        
        infoViewText.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(infoViewText)
        NSLayoutConstraint.activate([
            infoViewText.topAnchor.constraint(equalTo: infoView.topAnchor),
            infoViewText.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 14),
            infoViewText.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -14),
            infoViewText.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -14)
        ])
        
        let questionAmountPicker = UIPickerView()
        questionAmountPicker.dataSource = self
        questionAmountPicker.delegate = self
        questionAmountPicker.backgroundColor = .clear
        questionAmountPicker.showsSelectionIndicator = true
        self.questionAmountPickerStack.addArrangedSubview(questionAmountPicker)
        questionAmountPicker.selectRow(self.questionAmount - 3, inComponent: 0, animated: false)
        
        self.mainButtonStack.insertArrangedSubview(self.questionAmountPickerStack, at: 1)
        UIView.animate(withDuration: 0.14) {
            self.questionAmountPickerStack.alpha = 1
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.questionAmountOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = "\(self.questionAmountOptions[row])"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.questionAmount = row + 3
        self.questionCountButton.customtext = "Number of Questions: \(self.questionAmount)"
    }
}
