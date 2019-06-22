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
    @IBOutlet weak var barForSelectedCellView: CellSelectionView!
    
    var restaurantCollectionViewModel: RestaurantCollectionViewControllerModel = RestaurantCollectionViewControllerModel(restaurants: [])
    
    override func viewDidLoad() {
        setupRestaurantCollectionView()
        setupNavigationController()
        barForSelectedCellView.activeBarsCount = restaurantCollectionViewModel.restaurants.count
        barForSelectedCellView.highlightBar(index: 0)
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
        return restaurantCollectionViewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantCollectionViewModel.restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = restaurantCollectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCollectionViewCell.identifier, for: indexPath) as? RestaurantCollectionViewCell,
            let model = restaurantCollectionViewModel.getModelFor(indexPath) else {
            fatalError("Failed to dequeue restaurant cell")
        }
        let cellModel = RestaurantCollectionViewCellModel(model: model, classifiers: [Classifier(name: "Pizza"), Classifier(name: "Italian")])
        cell.model = cellModel
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let row = restaurantCollectionView.indexPathsForVisibleItems.first?.row {
            barForSelectedCellView.highlightBar(index: row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        barForSelectedCellView.highlightBar(index: indexPath.row)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
