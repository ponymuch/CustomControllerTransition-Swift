//
//  PresentationSecondViewController.swift
//  ControllerTransition
//
//  Created by PonyMuch on 2018/2/27.
//  Copyright © 2018年 PonyMuch. All rights reserved.
//

import UIKit

class PresentationSecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: self.view.bounds.width, height: 200)
    }

    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
         self.preferredContentSize = CGSize(width: self.view.bounds.width, height:
            CGFloat(sender.value))
    }
    
    deinit {
        print("PresentationSecondViewController Deinit")
    }
    
}
