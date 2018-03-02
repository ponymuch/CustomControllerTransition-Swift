//
//  SwipeInteractionTransition.swift
//  ControllerTransition
//
//  Created by PonyMuch on 2018/2/26.
//  Copyright © 2018年 PonyMuch. All rights reserved.
//

import UIKit

class SwipeInteractionTransition: UIPercentDrivenInteractiveTransition {
    
    private weak var transitionContext: UIViewControllerContextTransitioning!
    
    private(set) var gestureRecognizer: UIScreenEdgePanGestureRecognizer
    private(set) var edge: UIRectEdge

    init(gestureRecognizer: UIScreenEdgePanGestureRecognizer, edgeForDragging: UIRectEdge) {
        self.gestureRecognizer = gestureRecognizer
        self.edge = edgeForDragging
        super.init()
        self.gestureRecognizer.addTarget(self, action: #selector(SwipeInteractionTransition.gestureRecognizeDidUpdate(gestureRecognizer:)))
    }
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        super.startInteractiveTransition(transitionContext)
    }
    
    @objc func gestureRecognizeDidUpdate(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            break
        case .changed:
            self.update(percentForGestrue(gesture: gestureRecognizer))
        case .ended:
            if percentForGestrue(gesture: gestureRecognizer) >= 0.5 {
                self.finish()
            } else {
                self.cancel()
            }
            return
        default:
            self.cancel()
        }
    }
    
    func percentForGestrue(gesture: UIScreenEdgePanGestureRecognizer) -> CGFloat {
        let transitionContainerView = self.transitionContext.containerView
        
        let locationInSourceView = gesture.location(in: transitionContainerView)
        
        let width = transitionContainerView.bounds.width
        let height = transitionContainerView.bounds.height
        
        if self.edge == .right {
            return (width - locationInSourceView.x) / width
        } else if self.edge == .left {
            return locationInSourceView.x / width
        } else if self.edge == .bottom {
            return (height - locationInSourceView.y) / height
        } else if self.edge == .top {
            return locationInSourceView.y / height
        } else {
            return 0
        }
    }
    
    deinit {
        gestureRecognizer.removeTarget(self, action: #selector(SwipeInteractionTransition.gestureRecognizeDidUpdate(gestureRecognizer:)))
    }
    
}
