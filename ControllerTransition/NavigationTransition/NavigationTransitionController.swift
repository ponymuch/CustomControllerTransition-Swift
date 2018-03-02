//
//  NavigationTransitionController.swift
//  ControllerTransition
//
//  Created by PonyMuch on 2018/3/1.
//  Copyright © 2018年 PonyMuch. All rights reserved.
//

import UIKit

class NavigationTransitionController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self

    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return NavigationTransition()
    }
    

}
