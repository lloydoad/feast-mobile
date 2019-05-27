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
    
    var historyButton: UIButton!
    var settingButton: UIButton!
    var homeButton: UIButton!
    var locationBarOffset: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        
        self.collectionView.register(HomeView.self, forCellWithReuseIdentifier: HomeView.reUseIdentifier)
        self.collectionView.register(SettingView.self, forCellWithReuseIdentifier: SettingView.identifier)
        self.collectionView.register(HistoryView.self, forCellWithReuseIdentifier: HistoryView.identifier)
        self.initializeButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let region = self.view.frame.width - 30
        let menuSize = region / 3
        let screenEdge = self.view.frame.width
        let screenOffset = scrollView.contentOffset.x
        let offset = screenOffset/screenEdge - 1
        self.locationBarOffset.constant = offset * menuSize
    }
    
    func initializeButtons() {
        let width: CGFloat = self.view.frame.width - 30
        let height: CGFloat = 44
        let locationBarWidth: CGFloat = width / 3.5
        let locationBarHeight: CGFloat = 2
        
        let menu = UIStackView()
        menu.axis = .horizontal
        menu.alignment = .center
        menu.distribution = .fillEqually
        menu.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(menu)
        NSLayoutConstraint.activate([
            menu.widthAnchor.constraint(equalToConstant: width),
            menu.heightAnchor.constraint(equalToConstant: height),
            menu.topAnchor.constraint(equalTo: self.view.topAnchor, constant: height + 5),
            menu.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        self.historyButton = createMenuButton(title: "History", tag: 0)
        self.homeButton = createMenuButton(title: "Home", tag: 1)
        self.settingButton = createMenuButton(title: "Settings", tag: 2)
        self.historyButton.tag = 0
        self.homeButton.tag = 1
        self.settingButton.tag = 2
        menu.addArrangedSubview(self.historyButton)
        menu.addArrangedSubview(self.homeButton)
        menu.addArrangedSubview(self.settingButton)
        
        let locationBar = UIView()
        locationBar.layer.borderWidth = 0
        locationBar.backgroundColor = paleOrange
        locationBar.layer.borderColor = paleOrange.cgColor
        locationBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(locationBar)
        
        locationBar.topAnchor.constraint(equalTo: menu.bottomAnchor).isActive = true
        locationBar.widthAnchor.constraint(equalToConstant: locationBarWidth).isActive = true
        locationBar.heightAnchor.constraint(equalToConstant: locationBarHeight).isActive = true
        
        self.locationBarOffset = locationBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        self.locationBarOffset.isActive = true
    }
    
    func createMenuButton(title: String, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setAttributedTitle(
            NSAttributedString(
                string: title,
                attributes: [
                    NSAttributedString.Key.foregroundColor: paleOrange,
                    NSAttributedString.Key.font: headerFourFont
                ]),
            for: .normal
        )
        button.tag = tag
        button.addTarget(self, action: #selector(respondToMenu(sender:)), for: .touchUpInside)
        return button
    }
    
    @objc func respondToMenu(sender: UIButton) {
        self.collectionView.scrollToItem(
            at: IndexPath(row: sender.tag, section: 0),
            at: .centeredHorizontally,
            animated:true
        )
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
            return UICollectionViewCell(frame: self.view.frame)
        }
    }
}
