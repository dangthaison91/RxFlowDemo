//
//  HomeFlow.swift
//  RxFlowDemo
//
//  Created by dangthaison on 1/3/18.
//

import Foundation
import RxSwift
import RxFlow

enum HomeStep: Step {
    case initial, deeplink
}

class HomeFlow: Flow {
    var root: UIViewController { return tabbarController! }
    
    private weak var tabbarController: UITabBarController?
    
    init(tabbarController: UITabBarController) {
        self.tabbarController = tabbarController
    }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? HomeStep else { return NextFlowItems.stepNotHandled }
        switch step {
        case .initial:
            return setupHomeViewController()
        case .deeplink:
            return NextFlowItems.none
        }
    }
    
    private func setupHomeViewController() -> NextFlowItems {
        let scheduleListVC = StoryboardScene.Main.schedulesListViewController.instantiate()
        let scheduleListNaviController = UINavigationController(rootViewController: scheduleListVC)
        let scheduleFlow = ScheduleFlow(navigationController: scheduleListNaviController)
        
        let signOutVC = StoryboardScene.Main.signOutViewController.instantiate()
        let signOutNaviController = UINavigationController(rootViewController: signOutVC)

        tabbarController?.setViewControllers([scheduleListNaviController, signOutNaviController], animated: true)
        
        let signOutFlowItem = NextFlowItem(nextPresentable: signOutNaviController, nextStepper: signOutVC)
        let activityFlowItem = NextFlowItem(nextPresentable: scheduleFlow, nextStepper: scheduleListVC)
        
        return NextFlowItems.multiple(flowItems: [activityFlowItem, signOutFlowItem])
    }
}
