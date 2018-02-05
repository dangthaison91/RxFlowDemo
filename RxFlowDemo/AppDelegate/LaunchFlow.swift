//
//  LaunchFlow.swift
//  RxFlowDemo
//
//  Created by dangthaison on 1/3/18.
//

import Foundation
import RxFlow

enum LaunchStep: Step {
    case onboarding, signin, home
}

class LaunchFlow: Flow {
    let window: UIWindow
    
    let homeViewController = HomeViewController()

    lazy var root: UIViewController = self.homeViewController

    init(window: UIWindow) {
        self.window = window
    }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? LaunchStep else { return NextFlowItems.stepNotHandled }
        switch step {
            
        case .onboarding:
            return navigateToOnboardingScreen()
        case .signin:
            return navigateToLoginScreen()
        case .home:
            return navigateToHomeScreen()
        }
    }

    private func navigateToHomeScreen() -> NextFlowItems {
//        window.rootViewController = homeViewController
//        return NextFlowItems.stepNotHandled
//        root = homeViewController
        let homeFlow = HomeFlow(tabbarController: homeViewController)
       let nextFlow = NextFlowItem(nextPresentable: homeFlow, nextStepper: homeViewController)
        return NextFlowItems.one(flowItem: nextFlow)
    }
    
    private func navigateToLoginScreen() -> NextFlowItems {
        let signInViewController = StoryboardScene.Main.signInViewController.instantiate()
        let viewModel = SignInViewModel()
        (root as? SignInViewController)?.viewModel = viewModel
//        root = signInViewController
        return NextFlowItems.one(flowItem: NextFlowItem(nextPresentable: signInViewController, nextStepper: viewModel))
    }
    
    private func navigateToOnboardingScreen() -> NextFlowItems {
        return NextFlowItems.stepNotHandled
    }
}
