//
//  TabbarAnimatedTransition.swift
//  ControllerTransition
//
//  Created by PonyMuch on 2018/3/2.
//  Copyright © 2018年 PonyMuch. All rights reserved.
//

import UIKit

class TabbarAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.35
    
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

        containerView.addSubview(toView)
        
        fromView.alpha = 1.0
        toView.alpha = 0.3
        
        UIView.animate(withDuration: duration, animations: {
            fromView.alpha = 0.3
            toView.alpha = 1.0
        }) { finish in
            let cancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!cancelled)
        }
        
    }

}
