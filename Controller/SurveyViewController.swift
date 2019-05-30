//
//  SurveyViewController.swift
//  Feast
//
//  Created by Lloyd Dapaah on 5/29/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

extension SurveyView {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.optionTable.frame.height / 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    @objc func refreshInitialSurveyContents() {
        print("NOT SET")
    }
    
    @objc func closeSurvey() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func goToPreviousSurvey() {
        print("NOT SET")
    }
}
