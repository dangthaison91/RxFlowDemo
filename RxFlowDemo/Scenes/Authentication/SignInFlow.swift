//
//  SignInFlow.swift
//  RxFlowDemo
//
//  Created by dangthaison on 1/3/18.
//

import Foundation
import RxFlow

class SignInFlow: Flow {
    func navigate(to step: Step) -> NextFlowItems {
        return NextFlowItems.stepNotHandled
    }
    
    var root: UIViewController
    
    init(rootViewController: UIViewController) {
        self.root = rootViewController
    }
    
}
