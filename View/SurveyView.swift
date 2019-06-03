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

class SurveyView: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    let spacing: CGFloat = 25
    
    private var instructionLabel: UILabel!
    private var mainStack: UIStackView!
    var optionTable: UITableView!
    
    var previousSelectionButton: CustomButton?
    var selectedFrame: CGRect?
    var sequeSelectionString: String?
    
    var previousSelectionString: String? = nil
    var instructionText: String = ""
    var optionTableCellButtonHeight: CGFloat = 90
    var questions: [Int] = [1,1,1,1,1,1]
    var reviews: [Int] = [1,1,1,1]
    
    var remainingQuestions: Int = 3 {
        didSet {
            self.isFinalQuestionnaire = self.remainingQuestions == 1 ? true : false
        }
    }
    var isFinalQuestionnaire: Bool = false {
        didSet {
            self.instructionText = self.isFinalQuestionnaire ? InstructionType.Reviews.rawValue : InstructionType.Classifiers.rawValue
        }
    }
    var isInitialQuestionnaire: Bool = true {
        didSet {
            self.setupNavigationItems()
        }
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = mainBackground
        self.setupNavigationController()
        self.setupNavigationItems()
        self.setupMainStack()
        self.setupOptionTable()
        self.setupInstructionLabel()
        self.setupConstraints()
    }
    
    func setupNavigationController() {
        guard let navigationController = self.navigationController else { return }
        navigationController.delegate = self
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
    
    func setupMainStack() {
        self.mainStack = UIStackView()
        self.mainStack.spacing = spacing
        self.mainStack.axis = .vertical
        self.mainStack.alignment = .fill
        self.mainStack.distribution = .fill
        self.mainStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupOptionTable() {
        self.optionTable = UITableView()
        self.optionTable.delegate = self
        self.optionTable.dataSource = self
        self.optionTable.separatorStyle = .none
        self.optionTable.allowsSelection = false
        self.optionTable.backgroundColor = mainBackground
        self.optionTable.showsVerticalScrollIndicator = false
        self.optionTable.estimatedRowHeight = self.optionTableCellButtonHeight
        self.optionTable.register(SurveyOptionCellView.self, forCellReuseIdentifier: SurveyOptionCellView.reUseIdentifier)
    }
    
    func setupInstructionLabel() {
        self.instructionLabel = UILabel()
        self.instructionLabel.numberOfLines = 0
        self.instructionLabel.textColor = paleOrange
        self.instructionLabel.font = headerThreeFont
        self.instructionLabel.backgroundColor = .clear
        self.instructionLabel.text = self.instructionText
    }
    
    func setupConstraints() {
        self.view.addSubview(self.mainStack)
        self.mainStack.addArrangedSubview(self.instructionLabel)
        self.mainStack.addArrangedSubview(self.optionTable)
        
        if let previousSelection = self.previousSelectionString {
            let height: CGFloat = 53
            let width: CGFloat = self.mainStack.frame.width
            let frame: CGRect = CGRect(x: 0, y: 0, width: width, height: height)
            let button = CustomButton(frame: frame, type: .Dark, font: headerThreeFont)
            button.titleLabel?.numberOfLines = 0
            button.customtext = previousSelection
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalTo: button.titleLabel!.heightAnchor, constant: 20).isActive = true
            button.addTarget(self, action: #selector(self.goToPreviousSurvey), for: .touchUpInside)
            self.previousSelectionButton = button
            self.previousSelectionButton?.tag = SurveyViewAnimator.CustomAnimatorTag
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
