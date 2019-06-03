//
//  HomeViewController.swift
//  Feast
//
//  Created by Lloyd Dapaah on 5/29/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

extension RootView {
    @objc func presentRestaurantSurvey() {
        let surveyView = SurveyView()
//        surveyView.previousSelection = "American (Traditional), Pizza, Bar, Night Life"
        surveyView.remainingQuestions = 3
        let surveyViewNavigationController = SurveyNavigationView(rootViewController: surveyView)
        surveyViewNavigationController.delegate = surveyView
        
        self.present(surveyViewNavigationController, animated: true, completion: nil)
    }
}
