//
//  HistoryView.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/8/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class HistoryView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var historyTableView: UITableView!
    
    static public let nibFileName: String = "HistoryView"

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initView()
        self.registerCells()
    }

    private func initView() {
        Bundle.main.loadNibNamed(HistoryView.nibFileName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func registerCells() {
        historyTableView.register(SummaryTableViewCell.self, forCellReuseIdentifier: SummaryTableViewCell.identifier)
        historyTableView.register(UINib(nibName: SummaryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SummaryTableViewCell.identifier)
    }
}
