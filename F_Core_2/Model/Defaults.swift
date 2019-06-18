//
//  Defaults.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/9/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import Foundation

struct Defaults {
    
    static let numberOfQuestionSettingsKey = "numberOfQuestionSettings"
    static let userSessionKey = "com.save.usersession"
    
    struct Model {
        var numberOfQuestionSettings: Int
        
        init(_ json: [String: Int]) {
            self.numberOfQuestionSettings = json[numberOfQuestionSettingsKey] ?? 3
        }
    }
    
    static func save(_ numberOfQuestionSettings: Int){
        UserDefaults.standard.set([numberOfQuestionSettingsKey: numberOfQuestionSettings], forKey: userSessionKey)
    }
    
    static func getNumberOfQuestionsIndex()-> Model {
        return Model((UserDefaults.standard.value(forKey: userSessionKey) as? [String: Int]) ?? [:])
    }
    
    static func clearUserData(){
        UserDefaults.standard.removeObject(forKey: userSessionKey)
    }
}
