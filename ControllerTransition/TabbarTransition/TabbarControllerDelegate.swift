//
//  TabbarControllerDelegate.swift
//  ControllerTransition
//
//  Created by PonyMuch on 2018/3/2.
//  Copyright © 2018年 PonyMuch. All rights reserved.
//

import UIKit

class TabbarControllerDelegate: NSObject, UITabBarControllerDelegate {
    
    @IBOutlet weak var tabbarController: UITabBarController! {
        didSet {
            tabbarController.delegate =  self
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabbarAnimatedTransition()
    }
    
}
