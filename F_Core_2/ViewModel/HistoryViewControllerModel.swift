//
//  HistoryViewControllerModel.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/9/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import Foundation

struct HistoryViewControllerModel {
    private(set) var numberOfRowsInSection: Int = 1
    private(set) var numberOfSections: Int = 0
    
    private(set) var historyViewModels: [HistoryViewModel] = [] {
        didSet {
            self.numberOfSections = historyViewModels.count
        }
    }
    
    init() {
        // temp data
        defer {
            historyViewModels = [HistoryViewModel(), HistoryViewModel()]
        }
    }
    
    func historyViewModelFor(indexpath: IndexPath) -> HistoryViewModel? {
        if indexpath.section >= 0 && indexpath.section < historyViewModels.count {
            return historyViewModels[indexpath.section]
        }
        return nil
    }
    
    func getGeolocationFor(tag: Int) -> [Geolocation:Double]? {
        if tag >= 0 && tag < historyViewModels.count {
            return historyViewModels[tag].geolocation
        }
        
        return nil
    }
    
    mutating func deleteAt(tag: Int) -> Bool {
        if tag >= 0 && tag < historyViewModels.count {
            self.historyViewModels.remove(at: tag)
            return true
        }
        
        return false
    }
}
