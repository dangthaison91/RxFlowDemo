//
//  SignOutViewController.swift
//  RxFlowDemo
//
//  Created by dangthaison on 2/9/18.
//  Copyright © 2018 dangthaison. All rights reserved.
//

import UIKit
import RxFlow

class SignOutViewController: UIViewController, Stepper {

    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem = UITabBarItem(title: "Sign out", image: Asset.lockIcon.image, selectedImage: Asset.lockIcon.image)

        signOutButton
            .rx.tap
            .map { _ in return AppStep.signOut }
            .bind(to: step)
            .disposed(by: disposeBag)
    }
}
