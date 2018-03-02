//
//  SwipeTransitionDelegate.swift
//  ControllerTransition
//
//  Created by PonyMuch on 2018/2/26.
//  Copyright © 2018年 PonyMuch. All rights reserved.
//

import UIKit

class SwipeTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var gestureRecognizer: UIScreenEdgePanGestureRecognizer?
    var targetEdge: UIRectEdge!

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SwipeAnimatedTransition(targetEdge: self.targetEdge)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SwipeAnimatedTransition(targetEdge: self.targetEdge)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gesture = gestureRecognizer {
            return SwipeInteractionTransition(gestureRecognizer: gesture, edgeForDragging: targetEdge)
        } else {
            return nil
        }
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gesture = gestureRecognizer {
            return SwipeInteractionTransition(gestureRecognizer: gesture, edgeForDragging: targetEdge)
        } else {
            return nil
        }
    }
    
}
