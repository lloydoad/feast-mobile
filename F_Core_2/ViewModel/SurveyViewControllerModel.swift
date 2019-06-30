//
//  SurveyViewControllerModel.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/14/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

fileprivate let INDEX_ERROR_CLASSIFIER = Classifier(name: "Indexpath Error")

protocol SurveyViewControllerModelDelegate {
    func didGetClassifiers(fromSelection: String) -> Void
    func didGetReviews(fromSelection: String) -> Void
}

class SurveyViewControllerModel {
    private(set) var numberOfRows: Int = 1
    private(set) var numberOfSections: Int = 0
    private(set) var footerHeight: CGFloat = 23
    private(set) var defaultClassifierHeight: CGFloat = 53
    
    private(set) var shouldFetchRestaurants: Bool = false
    private(set) var selectedClassifiers: [Classifier] = []
    private(set) var contentCount: Int = 0
    
    private(set) var restaurants: [Restaurant] = [] {
        didSet {
            numberOfSections = restaurants.count
            defaultClassifierHeight = 120
            contentCount = restaurants.count
        }
    }
    
    private(set) var classifiers: [Classifier] = [] {
        didSet {
            numberOfSections = classifiers.count
            defaultClassifierHeight = 53
            contentCount = classifiers.count
        }
    }
    
    private var classifierCache: [[Classifier]] = []
    
    var delegate: SurveyViewControllerModelDelegate?
    
    init(selectedClassifiers: [Classifier], delegate: SurveyViewControllerModelDelegate?, isReviewSurvey: Bool) {
        self.selectedClassifiers = selectedClassifiers
        self.shouldFetchRestaurants = isReviewSurvey
        self.delegate = delegate
    }
    
    func getCellModel(indexPath: IndexPath) -> Any {
        let index = indexPath.section
        if shouldFetchRestaurants {
            guard index >= 0 && index < restaurants.count else { return INDEX_ERROR_CLASSIFIER }
            return restaurants[index]
        } else {
            guard index >= 0 && index < classifiers.count else { return INDEX_ERROR_CLASSIFIER }
            return classifiers[index]
        }
    }
    
    private func getStringRepresentationOfPreviousClassifiers() -> String {
        var stringRepresentation = ""
        selectedClassifiers.enumerated().forEach {stringRepresentation.append("\($0.offset == 0 ? "" : ", ")\($0.element.name)")}
        return stringRepresentation
    }
    
    func getSurveyTableContent(shouldFetchInitialClassifiers: Bool = false) {
        if shouldFetchRestaurants {
            restaurants = [
                placeholderRestaurant,
                placeholderRestaurant,
                placeholderRestaurant,
                placeholderRestaurant
            ]
            
            delegate?.didGetReviews(fromSelection: getStringRepresentationOfPreviousClassifiers())
        } else {
            let url = shouldFetchInitialClassifiers ? BaseURL.setup : BaseURL.addon
            let isNested = shouldFetchInitialClassifiers ? true : false
            
            if self.classifierCache.isEmpty {
                RequestSingleton.fetchClassifiers(url, previous: self.selectedClassifiers, isNested: isNested) { (classifiers) in
                    if isNested, let classifiers = classifiers as? [[Classifier]] {
                        self.classifierCache = classifiers
                        self.classifiers = self.classifierCache.removeFirst()
                        self.delegate?.didGetClassifiers(fromSelection: self.getStringRepresentationOfPreviousClassifiers())
                    } else if let classifiers = classifiers as? [Classifier] {
                        self.classifiers = classifiers
                        self.delegate?.didGetClassifiers(fromSelection: self.getStringRepresentationOfPreviousClassifiers())
                    }
                }
            } else {
                classifiers = classifierCache.removeFirst()
                delegate?.didGetClassifiers(fromSelection: getStringRepresentationOfPreviousClassifiers())
            }
        }
    }
}
