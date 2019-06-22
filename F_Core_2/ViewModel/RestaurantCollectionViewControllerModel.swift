//
//  RestaurantCollectionViewControllerModel.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/18/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import Foundation

struct RestaurantCollectionViewControllerModel {
    private(set) var restaurants: [Restaurant] = []
    let numberOfSections: Int = 1
    
    init(restaurants: [Restaurant]) {
        self.restaurants = restaurants
    }
    
    public func getModelFor(_ indexPath: IndexPath) -> Restaurant? {
        let index = indexPath.row
        guard index >= 0 && index < restaurants.count else { return nil }
        return restaurants[index]
    }
}
