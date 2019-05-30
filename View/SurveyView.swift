//
//  SurveyView.swift
//  Feast
//
//  Created by Lloyd Dapaah on 5/29/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

enum InstructionType: String {
    case Classifiers = "Pick whatever feels right"
    case Reviews = "Here are some shortened reviews, based on your picks. Which one do you prefer?"
}

class SurveyView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let spacing: CGFloat = 25
    
    var instructionLabel: UILabel!
    var optionTable: UITableView!
    var mainStack: UIStackView!
    var previousSelection: String?
    
    var isInitialQuestionnaire: Bool = true {
        didSet {
            self.setupNavigationItems()
            print("set back")
        }
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = mainBackground
        self.setupNavigationController()
        self.setupNavigationItems()
        self.setupContents()
    }
    
    func setupNavigationController() {
        guard let navigationController = self.navigationController else { return }
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.tintColor = paleOrange
        navigationController.navigationBar.barTintColor = mainBackground
    }
    
    func setupNavigationItems() {
        let backIcon = UIButton(frame: CGRect(x: 0, y: 0, width: 34, height: 34))
        backIcon.setImage(UIImage(named: "chevronIcon"), for: .normal)
        backIcon.imageView?.contentMode = .scaleAspectFit
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backIcon)
        navigationItem.leftBarButtonItem?.customView?.contentMode = .scaleAspectFit
        
        if self.isInitialQuestionnaire {
            backIcon.addTarget(self, action: #selector(closeSurvey), for: .touchUpInside)
            
            let refreshIcon = UIButton(frame: CGRect(x: 0, y: 0, width: 34, height: 34))
            refreshIcon.setImage(UIImage(named: "refreshIcon"), for: .normal)
            refreshIcon.imageView?.contentMode = .scaleAspectFit
            refreshIcon.addTarget(self, action: #selector(refreshInitialSurveyContents), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: refreshIcon)
        } else {
            backIcon.addTarget(self, action: #selector(goToPreviousSurvey), for: .touchUpInside)
            
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func setupContents() {
        self.mainStack = UIStackView()
        self.mainStack.spacing = spacing
        self.mainStack.axis = .vertical
        self.mainStack.alignment = .fill
        self.mainStack.distribution = .fill
        self.mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.instructionLabel = UILabel()
        self.instructionLabel.numberOfLines = 0
        self.instructionLabel.textColor = paleOrange
        self.instructionLabel.font = headerThreeFont
        self.instructionLabel.backgroundColor = .clear
        self.instructionLabel.text = InstructionType.Classifiers.rawValue
        
        self.optionTable = UITableView()
        self.optionTable.delegate = self
        self.optionTable.dataSource = self
        self.optionTable.separatorStyle = .none
        self.optionTable.backgroundColor = mainBackground
        
        self.view.addSubview(mainStack)
        self.mainStack.addArrangedSubview(self.instructionLabel)
        self.mainStack.addArrangedSubview(self.optionTable)
        
        if let previousSelection = self.previousSelection {
            let height: CGFloat = 53
            let width: CGFloat = self.mainStack.frame.width
            let frame: CGRect = CGRect(x: 0, y: 0, width: width, height: height)
            let button = CustomButton(frame: frame, type: .Dark, font: headerThreeFont)
            button.titleLabel?.numberOfLines = 0
            button.customtext = previousSelection
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalTo: button.titleLabel!.heightAnchor, constant: 20).isActive = true
            self.mainStack.insertArrangedSubview(button, at: 1)
        }
        
        NSLayoutConstraint.activate([
            self.mainStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: spacing / 2),
            self.mainStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: spacing),
            self.mainStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -spacing),
            self.mainStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -spacing),
        ])
    }
}
