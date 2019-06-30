//
//  SurveyViewController.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/10/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

fileprivate let TABLEVIEW_FALLBACK: Int = 0
fileprivate let PREVIOUS_CLASSIFIER_POSITION: Int = 1

class SurveyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SurveyViewControllerModelDelegate {
    static let identifier: String = "SurveyViewController"
    
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet weak var refreshBarButton: UIBarButtonItem!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var previousClassifierButton: ThemeUIButton!
    @IBOutlet weak var classifierTableView: UITableView!
    @IBOutlet var homeButton: UIButton!
    
    var surveyViewControllerModel: SurveyViewControllerModel?
    var previousClassifiers: [Classifier] = []
    var remainingQuestions: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
        self.setupPreviousClassifierButton()
        self.surveyViewControllerModel?.getSurveyTableContent(shouldFetchInitialClassifiers: previousClassifiers.isEmpty)
        self.navigationItem.titleView = homeButton
    }
    
    func setupPreviousClassifierButton() {
        if previousClassifiers.isEmpty {
            mainStackView.removeArrangedSubview(previousClassifierButton)
            previousClassifierButton.removeFromSuperview()
            refreshBarButton.isEnabled = true
        } else {
            mainStackView.insertArrangedSubview(previousClassifierButton, at: PREVIOUS_CLASSIFIER_POSITION)
            refreshBarButton.isEnabled = false
        }
    }
    
    func setupTable() {
        classifierTableView.dataSource = self
        classifierTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveyViewControllerModel?.numberOfRows ?? TABLEVIEW_FALLBACK
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return surveyViewControllerModel?.numberOfSections ?? TABLEVIEW_FALLBACK
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return surveyViewControllerModel?.footerHeight ?? CGFloat(TABLEVIEW_FALLBACK)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let count = surveyViewControllerModel?.contentCount else { return CGFloat(TABLEVIEW_FALLBACK) }
        let heightPerSection = classifierTableView.frame.height / CGFloat(count)
        let defaultHeight = surveyViewControllerModel?.defaultClassifierHeight ?? 0
        return max(heightPerSection - tableView.sectionFooterHeight, defaultHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = classifierTableView.dequeueReusableCell(withIdentifier: ClassifierTableViewCell.identifier, for: indexPath) as? ClassifierTableViewCell else { return UITableViewCell() }
        if let model = surveyViewControllerModel?.getCellModel(indexPath: indexPath) as? Classifier {
            cell.classifierModel = model
        } else if let model = surveyViewControllerModel?.getCellModel(indexPath: indexPath) as? Restaurant {
            cell.restaurantModel = model
        }
        cell.contentButton.addTarget(self, action: #selector(classifierSelected(_:)), for: .touchUpInside)
        return cell
    }
    
    func didGetClassifiers(fromSelection: String) {
        if self.previousClassifierButton != nil {
            self.previousClassifierButton.setTitle(fromSelection, for: .normal)
        }
        
        self.classifierTableView.reloadData()
    }
    
    func didGetReviews(fromSelection: String) {
        self.previousClassifierButton.setTitle(fromSelection, for: .normal)
        self.classifierTableView.reloadData()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        if previousClassifiers.isEmpty {
            self.navigationController?.dismiss(animated: true, completion: nil)
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func classifierSelected(_ sender: ThemeUIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if surveyViewControllerModel?.shouldFetchRestaurants ?? false {
            if let restaurantCollectionViewController = storyboard.instantiateViewController(withIdentifier: RestaurantCollectionViewController.identifier) as? RestaurantCollectionViewController {
                restaurantCollectionViewController.restaurantCollectionViewModel = RestaurantCollectionViewControllerModel(restaurants: surveyViewControllerModel?.restaurants ?? [])
                navigationController?.pushViewController(restaurantCollectionViewController, animated: true)
            }
            return
        }
        
        if let surveyViewController = storyboard.instantiateViewController(withIdentifier: SurveyViewController.identifier) as? SurveyViewController,
            let title = sender.title(for: .normal) {
            var selectedClassifiers = self.previousClassifiers
            let selectedClassifier = Classifier(name: title)
            selectedClassifiers.append(selectedClassifier)
            surveyViewController.previousClassifiers = selectedClassifiers
            surveyViewController.remainingQuestions = self.remainingQuestions - 1
            surveyViewController.surveyViewControllerModel = SurveyViewControllerModel(
                selectedClassifiers: selectedClassifiers,
                delegate: surveyViewController,
                isReviewSurvey: self.remainingQuestions - 1 > 1 ? false : true
            )
            
            navigationController?.pushViewController(surveyViewController, animated: true)
        }
    }
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        surveyViewControllerModel?.getSurveyTableContent()
    }
}
