//
//  HomeViewController.swift
//  RxFlowDemo
//
//  Created by sondt on 12/4/17.
//

import UIKit
import RxFlow

class HomeViewController: UITabBarController, Stepper {
//    lazy var homeFlow: HomeFlow = HomeFlow(tabbarController: self)
    lazy var coordinator: Coordinator =  Coordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        coordinator.coordinate(flow: homeFlow, withStepper: OneStepper(withSingleStep: HomeStep.initial))
//        self.delegate = self
    }
}
