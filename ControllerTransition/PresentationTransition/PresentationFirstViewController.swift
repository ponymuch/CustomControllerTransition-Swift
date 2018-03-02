//
//  PresentationFirstViewController.swift
//  ControllerTransition
//
//  Created by PonyMuch on 2018/2/27.
//  Copyright © 2018年 PonyMuch. All rights reserved.
//

import UIKit

class PresentationFirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func present(_ sender: UIButton) {
        
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "PresentationSecondViewController")
        
        let customPresentationController =  CustomPresentationController(presentedViewController: secondViewController, presenting: self)
        
        secondViewController.transitioningDelegate = customPresentationController
        
        self.present(secondViewController, animated: true, completion: nil)
        
    }
    
}
