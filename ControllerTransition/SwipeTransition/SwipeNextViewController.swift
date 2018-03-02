//
//  SwipeNextViewController.swift
//  ControllerTransition
//
//  Created by PonyMuch on 2018/2/26.
//  Copyright © 2018年 PonyMuch. All rights reserved.
//

import UIKit

class SwipeNextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(SwipeViewController.panGestureRecognizerAction(sender:)))
        panGesture.edges = .left
        self.view.addGestureRecognizer(panGesture)
    }
    
    @objc func panGestureRecognizerAction(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .began {
            self.dismissViewController(sender: sender)
        }
    }

    @IBAction func dismiss(_ sender: UIButton) {
       self.dismissViewController(sender: nil)
    }
    
    func dismissViewController(sender: UIScreenEdgePanGestureRecognizer?) {
        if self.transitioningDelegate?.isKind(of: SwipeTransitionDelegate.classForCoder()) == true {
            let customTransitionDelegate = transitioningDelegate as! SwipeTransitionDelegate
            if let gesture = sender {
                customTransitionDelegate.gestureRecognizer = gesture
            } else {
                customTransitionDelegate.gestureRecognizer = nil
            }
            customTransitionDelegate.targetEdge = .left
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
