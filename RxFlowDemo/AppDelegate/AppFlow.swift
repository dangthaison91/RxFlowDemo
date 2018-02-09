//
//  AppFlow.swift
//  RxFlowDemo
//
//  Created by dangthaison on 1/3/18.
//

import Foundation
import RxFlow

enum AppStep: Step {
    case onboarding, home, signIn,  signOut
}

class AppFlow: Flow {
    let window: UIWindow
    
    let homeViewController = HomeViewController()

    lazy var root: UIViewController = self.homeViewController

    init(window: UIWindow) {
        self.window = window
    }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else { return NextFlowItems.stepNotHandled }
        switch step {
            
        case .onboarding:
            return navigateToOnboardingScreen()
        case .signIn, .signOut:
            return navigateToLoginScreen()
        case .home:
            return navigateToHomeScreen()
        }
    }

    private func navigateToHomeScreen() -> NextFlowItems {
        let homeFlow = HomeFlow(tabbarController: homeViewController)
        let nextFlow = NextFlowItem(nextPresentable: homeFlow, nextStepper: homeFlow)
        
        self.window.rootViewController = homeViewController
        self.window.makeKeyAndVisible()
        return NextFlowItems.one(flowItem: nextFlow)
    }
    
    private func navigateToLoginScreen() -> NextFlowItems {
        let signInViewController = StoryboardScene.Main.signInViewController.instantiate()
        let signInNaviController = UINavigationController(rootViewController: signInViewController)
        signInViewController.viewModel = SignInViewModel()

        let authenFlow = AuthenticationFlow(rootViewController: signInNaviController)
        
        self.window.rootViewController = signInNaviController
        self.window.makeKeyAndVisible()

        let authenFlowItem = NextFlowItem(nextPresentable: signInNaviController, nextStepper: authenFlow)
        return NextFlowItems.one(flowItem: authenFlowItem)
    }
    
    private func navigateToOnboardingScreen() -> NextFlowItems {
        return NextFlowItems.stepNotHandled
    }
    
}
