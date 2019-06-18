//
//  SummaryTableViewCell.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/8/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    static public let identifier: String = "SummaryTableViewCell"

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var restaurantTitleLabel: UILabel!
    @IBOutlet weak var tagAndLocationLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var customBackgroundView: UIView!
    @IBOutlet weak var customTrashBackground: UIView!
    @IBOutlet weak var customMapBackground: UIView!
    @IBOutlet weak var customLabelBackground: UIView!
    
    var model: HistoryViewModel? {
        didSet {
            guard let model = model else {
                return
            }
            restaurantTitleLabel.text = model.restaurantTitle
            tagAndLocationLabel.text = model.tagAndLocation
            
            if let _ = model.imageURL {
                // load image into imageview
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addBorders()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    private func addBorders() {
        setupBorder(view: customBackgroundView)
        setupBorder(view: customTrashBackground)
        setupBorder(view: customMapBackground)
        setupBorder(view: customLabelBackground)
    }
    
    private func setupBorder(view: UIView, width: CGFloat = 0.8, color: CGColor = paleOrange.cgColor) {
        view.layer.borderColor = color
        view.layer.borderWidth = width
    }
}
