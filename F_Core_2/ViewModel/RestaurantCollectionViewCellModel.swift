//
//  RestaurantCollectionViewCellModel.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/22/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

struct RestaurantCollectionViewCellModel {
    struct Reviews {
        var ratingCount: Float
        var ratingString: String
        var ratingUrl: String
    }
    
    private(set) var restaurantIsOpenColor: UIColor
    private(set) var restaurantIsOpenString: String
    private(set) var reviewCountString: String
    private(set) var restaurantTitle: String
    private(set) var restaurantPrice: String
    private(set) var ratingImageName: String
    private(set) var locationString: String
    private(set) var overallRating: String
    private(set) var reviews: [Reviews]
    private(set) var tagString: String
    private(set) var model: Restaurant
    
    init(model: Restaurant, classifiers: [Classifier]) {
        self.model = model
        
        self.restaurantTitle = model.name
        self.restaurantIsOpenString = model.hours.is_open_now ? "open" : "closed"
        self.restaurantIsOpenColor = model.hours.is_open_now ? .green : red
        self.reviewCountString = "ERR Reviews"
        self.overallRating = "Rating: \(model.rating)"
        self.ratingImageName = "unnamed"
        self.locationString = "\(model.location.address1), \(model.location.city), \(model.location.state), \(model.location.country)"
        self.reviews = model.reviews.map {
            Reviews(ratingCount: $0.rating, ratingString: $0.text, ratingUrl: $0.url)
        }
        
        var tags = ""
        classifiers.enumerated().forEach { tags.append("\($0.offset == 0 ? "" : ", ")\($0.element.name)") }
        self.tagString = tags
        
        switch(model.price) {
        case "$":
            self.restaurantPrice = "Low"
            break
        case "$$":
            self.restaurantPrice = "Medium"
            break
        case "$$$":
            self.restaurantPrice = "High"
            break
        default:
            self.restaurantPrice = "High"
        }
    }
}
