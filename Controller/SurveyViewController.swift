//
//  SurveyViewController.swift
//  Feast
//
//  Created by Lloyd Dapaah on 5/29/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

extension SurveyView {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let frame = self.selectedFrame else { return nil }
        guard let text = self.sequeSelectionString else { return nil }
        let duration: TimeInterval = TimeInterval(UINavigationController.hideShowBarDuration)
        
        switch operation {
        case .push:
            return SurveyViewAnimator(duration: duration, isPresenting: true, originFrame: frame, previousSelectionString: text)
        case .pop:
            return SurveyViewAnimator(duration: duration, isPresenting: false, originFrame: frame, previousSelectionString: text)
        default:
            return SurveyViewAnimator(duration: duration, isPresenting: false, originFrame: frame, previousSelectionString: text)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.isFinalQuestionnaire {
            return UITableView.automaticDimension
        } else {
            return self.optionTableCellButtonHeight
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFinalQuestionnaire {
            return self.reviews.count
        } else {
            return self.questions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SurveyOptionCellView.reUseIdentifier, for: indexPath) as? SurveyOptionCellView else {
            assertionFailure("Unable to Dequeue Survey Option Cell View")
            return UITableViewCell()
        }
        
        if self.isFinalQuestionnaire {
            cell.contentButton.titleLabel?.font = headerFiveFont
            cell.contentButton.setTitle(
                """
                I love this place you get a huge slice of
                pizza for $4.25 you can’t beat that. Like
                that’s crazy! I got a slice with red
                sauce, pepperoni, onions extra…
                """,
                for: .normal)
            cell.contentButton.titleLabel?.sizeToFit()
            cell.contentButton.addTarget(self, action: #selector(self.didSelectPreferredReview(sender:)), for: .touchUpInside)
        } else {
            cell.contentButton.setTitle("\(indexPath.row)", for: .normal)
            cell.contentButton.addTarget(self, action: #selector(self.didSelectClassifier(sender:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    @objc func didSelectPreferredReview(sender: CustomButton) {
        print("review")
    }
    
    @objc func didSelectClassifier(sender: CustomButton) {
        guard let classifier = sender.titleLabel?.text else { return }
        
        var previousSelectionString: String = ""
        if let previousSelection = self.previousSelectionString {
            previousSelectionString.append(contentsOf: "\(previousSelection), ")
        }
        previousSelectionString.append(contentsOf: classifier)
        
        let subsequentSurveyView = SurveyView()
        subsequentSurveyView.previousSelectionString = previousSelectionString
        subsequentSurveyView.isInitialQuestionnaire = false
        subsequentSurveyView.remainingQuestions = self.remainingQuestions - 1
        
        self.selectedFrame = sender.superview?.convert(sender.frame, to: nil)
        self.sequeSelectionString = previousSelectionString
        
        self.navigationController?.pushViewController(subsequentSurveyView, animated: true)
    }
    
    @objc func refreshInitialSurveyContents() {
        print("NOT SET")
    }
    
    @objc func closeSurvey() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func goToPreviousSurvey() {
        self.navigationController?.popViewController(animated: true)
    }
}
