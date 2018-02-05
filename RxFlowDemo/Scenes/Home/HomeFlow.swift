//
//  HomeFlow.swift
//  RxFlowDemo
//
//  Created by dangthaison on 1/3/18.
//

import Foundation
import RxSwift
import RxFlow
import ESTabBarController_swift

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
        let signInVC = StoryboardScene.Main.signInViewController.instantiate()
        let signInViewModel = SignInViewModel()
        let signInNaviController = UINavigationController(rootViewController: signInVC)
        let signInFlow = SignInFlow(rootViewController: signInNaviController)
        
        let activityVC = StoryboardScene.Main.activityViewController.instantiate()
        let activityViewModel = ActivityViewModel()
        let activityNaviController = UINavigationController(rootViewController: activityVC)
        let scheduleFlow = ScheduleFlow(navigationController: activityNaviController)
        
        let moreVC = UIViewController()
        moreVC.tabBarItem = ESTabBarItem(title: "More", image: Asset.mailIcon.image, selectedImage: Asset.mailIcon.image)

        tabbarController?.setViewControllers([activityNaviController], animated: true)
        
        let signInFlowItem = NextFlowItem(nextPresentable: signInFlow, nextStepper: signInViewModel)
        let activityFlowItem = NextFlowItem(nextPresentable: scheduleFlow, nextStepper: activityVC)

        return NextFlowItems.multiple(flowItems: [signInFlowItem, activityFlowItem])
    }
}
