//
//  RestaurantCollectionViewController.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/17/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class RestaurantCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    static let identifier: String = "RestaurantCollectionViewController"
    @IBOutlet weak var restaurantCollectionView: UICollectionView!
    @IBOutlet var homeButton: UIButton!
    
    override func viewDidLoad() {
        setupRestaurantCollectionView()
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        navigationItem.titleView = homeButton
    }
    
    private func setupRestaurantCollectionView() {
        restaurantCollectionView.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: RestaurantCollectionViewCell.identifier)
        restaurantCollectionView.register(UINib(nibName: RestaurantCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: RestaurantCollectionViewCell.identifier)
        restaurantCollectionView.delegate = self
        restaurantCollectionView.dataSource = self
        restaurantCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: restaurantCollectionView.frame.width, height: restaurantCollectionView.frame.height)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = restaurantCollectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCollectionViewCell.identifier, for: indexPath) as? RestaurantCollectionViewCell else {
            fatalError("Failed to dequeue restaurant cell")
        }
        return cell
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
