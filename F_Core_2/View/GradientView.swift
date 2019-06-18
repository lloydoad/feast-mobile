//
//  GradientView.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/8/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var middleColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var endColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var start: Float = 1 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var middle: Float = 1 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var end: Float = 1 {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [startColor, middleColor, endColor].map{$0.cgColor}
        layer.locations = [start, middle, end].map{$0 as NSNumber}
    }
}
