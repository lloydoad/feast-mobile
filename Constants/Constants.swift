//
//  Colors.swift
//  Feast
//
//  Created by Lloyd Dapaah on 5/25/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

func getColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
}

let mainBackground = getColor(red: 17, green: 17, blue: 17, alpha: 1)
let paleOrange = getColor(red: 232, green: 159, blue: 86, alpha: 1)
let brightOrange = getColor(red: 255, green: 149, blue: 0, alpha: 1)
let white = getColor(red: 255, green: 255, blue: 255, alpha: 1)
let paleWhiteRed = getColor(red: 255, green: 216, blue: 216, alpha: 1)
let lightDark = getColor(red: 23, green: 23, blue: 23, alpha: 1)

let headerOneFont = UIFont.systemFont(ofSize: 60, weight: UIFont.Weight.thin)
let headerTwoFont = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
let headerThreeFont = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
let headerFourFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
