//
//  CustomPresentationController.swift
//  ControllerTransition
//
//  Created by PonyMuch on 2018/2/27.
//  Copyright © 2018年 PonyMuch. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.5
    
    var dimmingView: UIView!
    var presentationWrappingView: UIView!
    
    override var presentedView: UIView? {
        return self.presentationWrappingView
    }
    
    deinit {
        print("CustomPresentationController Deinit")
    }
    
    // MARK: - UIPresentationController
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.modalPresentationStyle = .custom
    }
    
    override func presentationTransitionWillBegin() {
        let presentedViewControllerView = super.presentedView
        
        // presentationWrapperView              <- shadow
        //   |- presentationRoundedCornerView   <- rounded corners (masksToBounds)
        //        |- presentedViewControllerWrapperView
        //             |- presentedViewControllerView (presentedViewController.view)
        
        presentationWrappingView = UIView(frame: self.frameOfPresentedViewInContainerView)
        presentationWrappingView.layer.shadowOpacity = 0.44
        presentationWrappingView.layer.shadowRadius = 13.0
        presentationWrappingView.layer.shadowOffset = CGSize(width: 0, height: -6.0)
        
        let presentationRoundedCornerView = UIView(frame: UIEdgeInsetsInsetRect(presentationWrappingView.bounds,  UIEdgeInsets(top: 0, left: 0, bottom: -16, right: 0)))
        
        presentationRoundedCornerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        presentationRoundedCornerView.layer.cornerRadius = 16
        presentationRoundedCornerView.layer.masksToBounds = true
        
        let presentedViewControllerWrapperView =  UIView(frame: UIEdgeInsetsInsetRect(presentationWrappingView.bounds,  UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)))
        presentedViewControllerWrapperView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        presentedViewControllerView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        presentedViewControllerView?.frame = presentedViewControllerWrapperView.bounds
        
        presentedViewControllerWrapperView.addSubview(presentedViewControllerView!)
        
        presentationRoundedCornerView.addSubview(presentedViewControllerWrapperView)
        
        presentationWrappingView.addSubview(presentationRoundedCornerView)
        
        dimmingView = UIView(frame: self.containerView?.bounds ?? .zero)
        dimmingView.backgroundColor = UIColor.black
        dimmingView.isOpaque = false
        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CustomPresentationController.dimmingViewTapped(sender:))))
        self.containerView?.addSubview(dimmingView)
        
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        dimmingView.alpha  = 0.0
        transitionCoordinator?.animate(alongsideTransition: { context in
            self.dimmingView.alpha = 0.5
        }, completion: nil)
        
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if completed == false {
            self.presentationWrappingView = nil
            self.dimmingView = nil
        }
    }
    
    override func dismissalTransitionWillBegin() {
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: { context in
            self.dimmingView.alpha = 0.0
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed == true {
            self.presentationWrappingView = nil
            self.dimmingView = nil
        }
    }
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        if let containervc = container as? UIViewController {
            if containervc == self.presentedViewController {
                self.containerView?.setNeedsLayout()
            }
        }
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        if let containervc = container as? UIViewController {
            if containervc == self.presentedViewController {
                return containervc.preferredContentSize
            } else {
                return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
            }
        } else {
            return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        
        let presentedViewContentSize = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: self.containerView!.bounds.size)
        
        var presentedViewControllerFrame = self.containerView!.bounds
        presentedViewControllerFrame.size.height = presentedViewContentSize.height
 
        presentedViewControllerFrame.origin.y = self.containerView!.bounds.maxY - presentedViewContentSize.height + 16
        return presentedViewControllerFrame
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        dimmingView.frame = self.containerView!.bounds
        presentationWrappingView.frame = self.frameOfPresentedViewInContainerView
    }
    
    // MARK: - TapGesture
    @objc func dimmingViewTapped(sender: UITapGestureRecognizer) {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        guard let context = transitionContext else { return 0.0 }
        return context.isAnimated ? duration : 0.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        
        let containerView = transitionContext.containerView
        
        let fromView: UIView
        let toView: UIView
        
        let isPresenting = toViewController.presentingViewController == fromViewController
        
        if isPresenting == true {
            fromView = fromViewController.view!
            toView = transitionContext.view(forKey: .to)!
            containerView.addSubview(toView)
        } else {
            fromView = transitionContext.view(forKey: .from)!
            toView = toViewController.view!
        }
        
        let _ = transitionContext.initialFrame(for: fromViewController)
        var fromViewfinalFrame = transitionContext.finalFrame(for: fromViewController)
        
        var toViewInitialFrame = transitionContext.initialFrame(for: toViewController)
        let toViewFinalFrame = transitionContext.finalFrame(for: toViewController)
        
        if isPresenting == true {
            toViewInitialFrame.origin = CGPoint(x: containerView.bounds.minX, y: containerView.bounds.maxY)
            toViewInitialFrame.size = toViewFinalFrame.size
            toView.frame = toViewInitialFrame
        } else {
            fromViewfinalFrame = fromView.frame.offsetBy(dx: 0, dy: fromView.frame.height)
        }
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: transitionDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            if isPresenting == true {
                toView.frame = toViewFinalFrame
            } else {
                fromView.frame = fromViewfinalFrame
            }
        }) { finish in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
        
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

}
