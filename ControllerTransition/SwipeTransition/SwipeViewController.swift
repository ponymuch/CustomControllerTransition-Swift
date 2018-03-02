//
//  SwipeViewController.swift
//  ControllerTransition
//
//  Created by PonyMuch on 2018/2/22.
//  Copyright © 2018年 PonyMuch. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController {
    
    lazy var customTransitionDelegate = SwipeTransitionDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(SwipeViewController.panGestureRecognizerAction(sender:)))
        panGesture.edges = .right
        self.view.addGestureRecognizer(panGesture)
    }
    
    @objc func panGestureRecognizerAction(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .began {
            self.pushNextController(sender)
        }
    }
    
    @IBAction func swipe(_ sender: UIButton) {
        self.pushNextController(nil)
    }
    
    func pushNextController(_ sender: UIScreenEdgePanGestureRecognizer?) {
        guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "SwipeNextViewController") else { return }
       
        if let gesture = sender {
            customTransitionDelegate.gestureRecognizer = gesture
        } else {
            customTransitionDelegate.gestureRecognizer = nil
        }
        customTransitionDelegate.targetEdge = .right
        
        nextViewController.transitioningDelegate = customTransitionDelegate
        
        nextViewController.modalPresentationStyle = .fullScreen
        
        self.present(nextViewController, animated: true, completion: nil)

    }


}
