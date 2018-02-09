//
//  AppDelegateViewModel.swift
//  RxFlowDemo
//
//  Created by dangthaison on 1/3/18.
//

import Foundation
import RxFlow

protocol RootDependency {
    var userDefault: UserDefaults { get }
}

struct RootComponent: RootDependency {
    let userDefault: UserDefaults
    
    init(userDefault: UserDefaults = UserDefaults.standard) {
        self.userDefault = userDefault
    }
}

class AppDelegateViewModel: Stepper {
    let component: RootComponent
    
    init(component: RootComponent = RootComponent()) {
        self.component = component
        
        if component.userDefault.userLoggedIn {
            step.accept(AppStep.signIn)
        } else {
            step.accept(AppStep.home)
        }
    }
}
