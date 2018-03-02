//
//  ViewController.swift
//  ControllerTransition
//
//  Created by PonyMuch on 2018/2/22.
//  Copyright © 2018年 PonyMuch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func presentClicket(_ sender: UIButton) {
        let dissolveViewController = self.storyboard!.instantiateViewController(withIdentifier: "CrossDissolveViewController")
        dissolveViewController.modalPresentationStyle = .fullScreen
        dissolveViewController.transitioningDelegate = self
        self.present(dissolveViewController, animated: true, completion: nil)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomAnimator()
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomAnimator()
    }
    
}

