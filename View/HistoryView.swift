//
//  HistoryView.swift
//  Feast
//
//  Created by Lloyd Dapaah on 5/25/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class HistoryView: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    static let identifier: String = "HistoryViewCellIdentifier"
    
    var restaurantDate: [Int] = [1,1,1]
    var mainTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let bounds = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        self.frame = bounds
        
        self.setupMainTable()
        self.mainTableView.register(DataSummaryCellView.self, forCellReuseIdentifier: DataSummaryCellView.reUseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Supported")
    }
    
    func setupMainTable() {
        let space: CGFloat = 20
        let topOffset: CGFloat = 115
        let contentWidth:CGFloat = frame.width - (2 * space)
        
        self.mainTableView = UITableView()
        self.mainTableView.dataSource = self
        self.mainTableView.delegate = self
        self.mainTableView.rowHeight = UITableView.automaticDimension
        self.mainTableView.estimatedRowHeight = 231
        self.mainTableView.separatorStyle = .singleLine
        self.mainTableView.showsVerticalScrollIndicator = false
        self.mainTableView.separatorColor = mainBackground
        self.mainTableView.backgroundColor = mainBackground
        self.mainTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.mainTableView)
        NSLayoutConstraint.activate([
            self.mainTableView.topAnchor.constraint(equalTo: self.topAnchor, constant: topOffset),
            self.mainTableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.mainTableView.widthAnchor.constraint(equalToConstant: contentWidth),
            self.mainTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.mainTableView.dequeueReusableCell(withIdentifier: DataSummaryCellView.reUseIdentifier, for: indexPath)
    }
    
}
