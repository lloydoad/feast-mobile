//
//  HomeViewController.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/10/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

extension RootViewController {
    @objc func openDealSafariWindow() {
        guard let url = homeViewControllerModel?.featuredDealUrl else { return }
        /*
         open external window with safari and url
         */
        print(url)
    }
    
    @objc func openSurveyView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)        
        if let numberOfQuestions = homeViewControllerModel?.getSurveyLimit(),
            let surveyViewController = storyboard.instantiateViewController(withIdentifier: "SurveyViewController") as? SurveyViewController {
            let surveyNavigationViewController = SurveyNavigationController()
            let surveyViewControllerModel = SurveyViewControllerModel(selectedClassifiers: [], delegate: surveyViewController, isReviewSurvey: false)
            
            surveyNavigationViewController.viewControllers.append(surveyViewController)
            surveyViewController.previousClassifiers = []
            surveyViewController.remainingQuestions = numberOfQuestions
            surveyViewController.surveyViewControllerModel = surveyViewControllerModel
            self.present(surveyNavigationViewController, animated: true, completion: nil)
        }
    }
}
