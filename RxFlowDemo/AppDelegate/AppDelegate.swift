//
//  AppDelegate.swift
//  RxFlowDemo
//
//  Created by sondt on 12/1/17.
//

import UIKit
import RxFlow

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    let viewModel: AppDelegateViewModel = AppDelegateViewModel()
    var coordinator: Coordinator = Coordinator()
    
    lazy var rootFlow: LaunchFlow = {
        guard let window = window else { fatalError("Cannot get window: UIWindow?") }
        return LaunchFlow(window: window)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        Flows.whenReady(flow1: rootFlow) { [unowned self] (viewController) in
//            self.window?.rootViewController = viewController
//            self.window?.makeKeyAndVisible()
//        }
        coordinator.coordinate(flow: rootFlow, withStepper: viewModel)
        return true
    }
}
