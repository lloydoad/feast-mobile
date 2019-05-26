//
//  MainTableViewController.swift
//  Feast
//
//  Created by Lloyd Dapaah on 5/25/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class RootView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        
        self.collectionView.register(HomeView.self, forCellWithReuseIdentifier: HomeView.reUseIdentifier)
        self.collectionView.register(SettingView.self, forCellWithReuseIdentifier: SettingView.identifier)
        self.collectionView.register(HistoryView.self, forCellWithReuseIdentifier: HistoryView.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    func setupCollectionView() {
        let frame = self.view.frame
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.width, height: frame.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.isPagingEnabled = true
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let width = self.view.frame.width
        let height = self.view.frame.height
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        switch indexPath.row {
        case 0:
            return self.collectionView.dequeueReusableCell(withReuseIdentifier: HistoryView.identifier, for: indexPath) as! HistoryView
        case 1:
            let homeview = self.collectionView.dequeueReusableCell(withReuseIdentifier: HomeView.reUseIdentifier, for: indexPath) as! HomeView
            homeview.constraintFrame = frame
            return homeview
        case 2:
            return self.collectionView.dequeueReusableCell(withReuseIdentifier: SettingView.identifier, for: indexPath) as! SettingView
        default:
            return self.collectionView.dequeueReusableCell(withReuseIdentifier: HomeView.reUseIdentifier, for: indexPath) as! HomeView
        }
    }
}
