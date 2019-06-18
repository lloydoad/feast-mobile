//
//  HomeViewControllerModel.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/10/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import Foundation

struct HomeViewControllerModel {
    private(set) var featuredDealUrl: String?
    private(set) var featuredImageUrl: String?
    private(set) var featuredDealHeader: String = "KOREAN?"
    private(set) var featuredDealDescription: String = "Searching for the best deals in your area. Stay tuned!"
    private var surveyQuestionLimit: Int = 3
    
    public mutating func setSurveyLimit(_ value: Int) {
        if value > 3 && value < 6 {
            surveyQuestionLimit = value
        }
    }
    
    public func getSurveyLimit() -> Int {
        return surveyQuestionLimit
    }
}
