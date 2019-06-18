//
//  RestaurantCollectionViewCell.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/17/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "RestaurantCollectionViewCell"
    
    // content
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var restaurantTitleLabel: UILabel!
    @IBOutlet weak var isOpenIndicatorView: UIView!
    @IBOutlet weak var isOpenIndicatorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    // buttons
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var yelpButton: UIButton!
    @IBOutlet weak var directionsButton: UIButton!
    
    // containers
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var mainBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBorders()
        previousButton.isEnabled = false
    }
    
    private func setupBorders() {
        addBorderTo(yelpButton)
        addBorderTo(directionsButton)
        addBorderTo(backgroundImageView)
        addBorderTo(mainContentView)
        addBorderTo(mainBackgroundView)
        backgroundImageView.layer.cornerRadius = 0
    }
    
    private func addBorderTo(_ view: UIView) {
        view.layer.borderColor = getColor(red: 186, green: 57, blue: 57, alpha: 1).cgColor
        view.layer.borderWidth = 0.6
        view.layer.cornerRadius = 5
    }
    
    @IBAction func previousButtonTapped(_ sender: Any) {
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
    }
    
    @IBAction func readMoreButtonTapped(_ sender: Any) {
    }
    
    @IBAction func yelpButtonTapped(_ sender: Any) {
    }
    
    @IBAction func directionsButtonTapped(_ sender: Any) {
    }
}
