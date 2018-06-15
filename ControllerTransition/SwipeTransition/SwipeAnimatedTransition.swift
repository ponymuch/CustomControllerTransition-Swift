//
//  SwipeAnimatedTransition.swift
//  ControllerTransition
//
//  Created by PonyMuch on 2018/2/26.
//  Copyright © 2018年 PonyMuch. All rights reserved.
//

import UIKit

class SwipeAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {

    var targetEdge: UIRectEdge
    
    init(targetEdge: UIRectEdge) {
        self.targetEdge = targetEdge
    }
    
    private let duration = 0.35
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        
        let containerView = transitionContext.containerView
        
        // For a Presentation:
        //      fromView = The presenting view.
        //      toView   = The presented view.
        // For a Dismissal:
        //      fromView = The presented view.
        //      toView   = The presenting view.
        
        var fromView: UIView
        var toView: UIView
        
        if transitionContext.responds(to: #selector(UIViewControllerContextTransitioning.view(forKey:))) {
            fromView = transitionContext.view(forKey: .from)!
            toView = transitionContext.view(forKey: .to)!
        } else {
            fromView = fromViewController.view
            toView = toViewController.view
        }
        
        let isPresenting = (toViewController.presentingViewController == fromViewController)
        
        let fromFrame = transitionContext.initialFrame(for: fromViewController)
        let toFrame = transitionContext.finalFrame(for: toViewController)
        
        var offset: CGVector!
        switch self.targetEdge {
        case .top:
            offset = CGVector(dx: 0, dy: 1)
        case .bottom:
            offset = CGVector(dx: 0, dy: -1)
        case .left:
            offset = CGVector(dx: 1, dy: 0)
        case .right:
            offset = CGVector(dx: -1, dy: 0)
        default:
            offset = CGVector()
        }
        
        if isPresenting {
            fromView.frame = fromFrame
            toView.frame  = toFrame.offsetBy(dx: toFrame.size.width * offset.dx * -1, dy: toFrame.size.height * offset.dy * -1)
            containerView.addSubview(toView)
        } else {
            fromView.frame = fromFrame
            toView.frame = toFrame
            containerView.insertSubview(toView, belowSubview: fromView)
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            if isPresenting {
                toView.frame = toFrame
            } else {
                fromView.frame =  fromFrame.offsetBy(dx: fromFrame.size.width * offset.dx, dy: fromFrame.size.height * offset.dy)
            }
        }) { finished in
            let wasCancelled = transitionContext.transitionWasCancelled
            if wasCancelled {
                toView.removeFromSuperview()
            }
            transitionContext.completeTransition(!wasCancelled)
        }

    }
    

}
