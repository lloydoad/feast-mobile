//
//  Restaurant.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/16/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import Foundation

struct Restaurant: Codable {
    struct Hours: Codable {
        let is_open_now: Bool
    }
    
    struct Location: Codable {
        let address1: String
        let city: String
        let country: String
        let state: String
    }
    
    struct Review: Codable {
        let rating: Float
        let text: String
        let url: String
    }
    
    let hours: Hours
    let location: Location
    let name: String
    let photos: [String]
    let price: String
    let rating: Float
    let reviews: [Review]
}

let placeholderRestaurant: Restaurant = Restaurant(
    hours: Restaurant.Hours(
        is_open_now: true
    ),
    location: Restaurant.Location(
        address1: "1234 main street",
        city: "Orlando",
        country: "US",
        state: "FL"
    ),
    name: "Some Restauranty Place",
    photos: [],
    price: "$",
    rating: 4.2,
    reviews: [
        Restaurant.Review(
            rating: 4,
            text: "ipsum lorem lorem ipsum, ipsum lorem lorem ipsum, ipsum lorem lorem ipsum, ipsum lorem lorem ipsum, ipsum lorem lorem ipsum, ipsum lorem lorem ipsum, ipsum lorem lorem ipsum,",
            url: "some url"
        ),
        Restaurant.Review(
            rating: 4,
            text: "ipsum lorem lorem ipsum, ipsum lorem lorem ipsum, ipsum lorem lorem ipsum, ipsum lorem lorem ipsum, ipsum lorem lorem ipsum, ipsum lorem lorem ipsum, ipsum lorem lorem ipsum,",
            url: "some url"
        ),
        Restaurant.Review(
            rating: 4,
            text: "ipsum lorem lorem ipsum, ipsum lorem lorem ipsum, ipsum lorem lorem ipsum, ipsum lorem lorem ipsum, ipsum lorem lorem ipsum, ipsum lorem lorem ipsum, ipsum lorem lorem ipsum,",
            url: "some url"
        )
    ])
