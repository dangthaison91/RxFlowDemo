//
//  HomeViewController.swift
//  RxFlowDemo
//
//  Created by sondt on 12/4/17.
//

import UIKit
import RxFlow

class HomeViewController: UITabBarController, Stepper {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        step.accept(HomeStep.initial)

    }
}
