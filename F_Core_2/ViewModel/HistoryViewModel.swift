//
//  HistoryViewModel.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/9/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import Foundation

struct HistoryViewModel {
    var restaurantID: Int = 0
    var restaurantTitle: String = "Restaurant A"
    var tagAndLocation: String = "Tag 1, Tag 2, Tag 3\nLocation and Address"
    var geolocation: [Geolocation:Double] = [Geolocation.Longitude: 0.0, Geolocation.Latitude: 0.0]
    var imageURL: URL?
}
