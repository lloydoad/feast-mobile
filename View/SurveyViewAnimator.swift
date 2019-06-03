//
//  SurveyViewAnimator.swift
//  Feast
//
//  Created by Lloyd Dapaah on 6/2/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit

class SurveyViewAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    public static let CustomAnimatorTag = 99
    
    var duration: TimeInterval
    var isPresenting: Bool
    var originFrame: CGRect
    var previousSelectionString: String
    
    init(duration: TimeInterval, isPresenting: Bool, originFrame: CGRect, previousSelectionString: String) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        self.previousSelectionString = previousSelectionString
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        if self.isPresenting {
            // add to view on top
            container.addSubview(toView)
        } else {
            // add to view below current view
            container.insertSubview(toView, belowSubview: fromView)
        }
        
        let viewWithPreviousSelectionButton = self.isPresenting ? toView : fromView
        guard let previousSelectionButton = viewWithPreviousSelectionButton.viewWithTag(SurveyViewAnimator.CustomAnimatorTag) as? CustomButton else { return }
        previousSelectionButton.alpha = 0
        
        // add transition obj to be animated
        let transitionButtonView = CustomButton(
            frame: self.originFrame,
            type: previousSelectionButton.customType,
            font: previousSelectionButton.customFont
        )
        transitionButtonView.setTitle(self.previousSelectionString, for: .normal)
        container.addSubview(transitionButtonView)
        
        // place views side by side
        let absFromViewFrame = fromView.superview?.convert(fromView.frame, to: nil) ?? fromView.frame
        toView.frame = isPresenting ? CGRect(x: absFromViewFrame.width, y: absFromViewFrame.minY, width: toView.frame.width, height: toView.frame.height) : toView.frame
        toView.alpha = isPresenting ? 0 : 1
        toView.layoutIfNeeded()
        
        // animate
        UIView.animate(withDuration: duration, animations: {
            let absoluteRight = previousSelectionButton.superview?.convert(previousSelectionButton.frame, to: nil) ?? previousSelectionButton.frame
            let absolutePos = CGRect(x: absoluteRight.minX - toView.frame.width, y: absoluteRight.minY, width: absoluteRight.width, height: absoluteRight.height)
            
            transitionButtonView.frame = self.isPresenting ? absolutePos : self.originFrame
            viewWithPreviousSelectionButton.frame = self.isPresenting ? fromView.frame : CGRect(x: absFromViewFrame.width, y: absFromViewFrame.minY, width: toView.frame.width, height: toView.frame.height)
            viewWithPreviousSelectionButton.alpha = self.isPresenting ? 1 : 0
        }, completion: { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            transitionButtonView.removeFromSuperview()
            previousSelectionButton.alpha = 1
        })
    }
}
