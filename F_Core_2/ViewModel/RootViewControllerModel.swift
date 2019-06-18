//
//  RootViewControllerModel.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/9/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

enum ButtonTitle: String {
    case History = "History"
    case Home = "Home"
    case Settings = "Settings"
}

struct RootViewControllerModel {
    var left: CGFloat = 0
    var middle: CGFloat = 0
    var right: CGFloat = 0
    var frame: CGRect? {
        didSet {
            if let frame = frame {
                middle = frame.width
                right = middle * 2
            }
        }
    }
    
    init(frame: CGRect) {
        defer {
            self.frame = frame
        }
    }
    
    func pageViewTo(scrollview: UIScrollView, title: ButtonTitle) {
        switch title {
        case .History:
            scrollview.setContentOffset(CGPoint(x: left, y: 0), animated: true)
            break
        case .Home:
            scrollview.setContentOffset(CGPoint(x: middle, y: 0), animated: true)
            break
        case .Settings:
            scrollview.setContentOffset(CGPoint(x: right, y: 0), animated: true)
            break
        }
    }
    
    func getNavigationOffset(scrollview: UIScrollView) -> CGFloat? {
        guard let frame = frame else { return nil }
        let region = frame.width - 30
        let menuSize = region / 3
        let screenEdge = frame.width
        let screenOffset = scrollview.contentOffset.x
        let offset = screenOffset/screenEdge - 1
        return offset * menuSize
    }
}
