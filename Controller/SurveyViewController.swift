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
        return self.optionTable.frame.height / CGFloat(self.questions.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SurveyOptionCellView.reUseIdentifier, for: indexPath) as! SurveyOptionCellView
        cell.title = "Yeet??"
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
