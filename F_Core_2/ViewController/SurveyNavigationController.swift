//
//  NavigationController.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/10/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class SurveyNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = mainBackground
        self.navigationBar.backgroundColor = .clear
        self.navigationBar.barStyle = .black
    }
}
