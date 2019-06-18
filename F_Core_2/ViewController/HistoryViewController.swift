//
//  HistoryViewController.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/9/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return historyViewControllerModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyViewControllerModel?.numberOfRowsInSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.historyView.historyTableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.identifier) as? SummaryTableViewCell,
            let cellModel = historyViewControllerModel?.historyViewModelFor(indexpath: indexPath) else {
            return UITableViewCell()
        }
        cell.model = cellModel
        cell.mapButton.tag = indexPath.section
        cell.mapButton.addTarget(self, action: #selector(openMapToLocation(_:)), for: .touchUpInside)
        cell.trashButton.tag = indexPath.section
        cell.trashButton.addTarget(self, action: #selector(deleteCellSummary(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func openMapToLocation(_ sender: UIButton) {
        guard let geolocation = historyViewControllerModel?.getGeolocationFor(tag: sender.tag) else {
            return
        }
        
        print(geolocation)
    }
    
    @objc func deleteCellSummary(_ sender: UIButton) {
        if historyViewControllerModel?.deleteAt(tag: sender.tag) ?? false {
            historyView.historyTableView.reloadData()
        }
    }
}
