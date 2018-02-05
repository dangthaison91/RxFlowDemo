//
//  ScheduleFlow.swift
//  RxFlowDemo
//
//  Created by dangthaison on 1/3/18.
//

import Foundation
import RxFlow

enum ScheduleStep: Step {
    case createSchedule, scheduleCreated, cancel
}

class ScheduleFlow: Flow {
   
    var root: UIViewController { return navigationController! }
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? ScheduleStep else { return NextFlowItems.stepNotHandled }
        
        switch step {
        case .createSchedule:
            let createScheduleViewController = CreateScheduleViewController()
            let createScheduleViewModel = CreateScheduleViewModel(id: nil)
            let navi = UINavigationController(rootViewController: createScheduleViewController)
            
            let nextFlow = NextFlowItem(nextPresentable: navi, nextStepper: createScheduleViewModel)
            let cancelFlow = NextFlowItem(nextPresentable: navi, nextStepper: createScheduleViewController)
            
            root.present(navi, animated: true, completion: nil)
            
            return NextFlowItems.multiple(flowItems: [nextFlow, cancelFlow])
            
        case .scheduleCreated, .cancel:
            root.dismiss(animated: true, completion: nil)
            return NextFlowItems.none
        }
    }
    
}
