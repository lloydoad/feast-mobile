//
//  CellSelectionView.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/22/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class CellSelectionView: UIView {
    let isActiveColor: UIColor = red
    let isInActiveColor: UIColor = .white
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet var barView: UIView!
    
    var activeBarsCount: Int = 0 {
        didSet {
            containerStackView.arrangedSubviews.forEach {
                containerStackView.removeArrangedSubview($0)
            }
            
            for tag in 0..<activeBarsCount {
                let bar = UIView()
                initBarView(bar)
                bar.tag = tag
                bar.backgroundColor = isInActiveColor
                containerStackView.addArrangedSubview(bar)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customAwakeFromNib()
    }
    
    func customAwakeFromNib() {
        Bundle.main.loadNibNamed("CellSelectionView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func initBarView(_ bar: UIView) {
        bar.layer.cornerRadius = 3
    }
    
    func highlightBar(index: Int) {
        containerStackView.arrangedSubviews.enumerated().forEach {
            if $0.offset == index {
                $0.element.backgroundColor = isActiveColor
            } else {
                $0.element.backgroundColor = isInActiveColor
            }
        }
    }
}
