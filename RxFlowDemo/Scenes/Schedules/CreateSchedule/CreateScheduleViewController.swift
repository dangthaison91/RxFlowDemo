//
//  CreateScheduleViewController.swift
//  RxFlowDemo
//
//  Created by dangthaison on 12/25/17.
//

import UIKit
import RxCocoa
import RxSwift
import RxFlow
import SwiftDate

enum ScheduleDateType: String {
    case once, daily, weekly
}

final class CreateScheduleViewController: UIViewController, Stepper {

    // UI

    var viewModel: CreateScheduleViewModel! = CreateScheduleViewModel(id: nil)
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureViewModel()
    }
}

private extension CreateScheduleViewController {
    func configureViewModel() {
        viewModel
            .createAction
            .elements
            .subscribeNext { [weak self] in
                let alert = UIAlertController(title: "Succesfull", message: "Medication schedule has been created", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self?.step.accept(ScheduleStep.scheduleCreated)
                })
                alert.addAction(okAction)
                self?.present(alert, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
      func configureViews() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = cancelButton

        saveButton
            .rx.tap
            .bind(to: viewModel.createAction.inputs)
            .disposed(by: disposeBag)
        
        cancelButton
            .rx.tap
            .subscribeNext { [weak self] in
                self?.step.accept(ScheduleStep.cancel)
            }
            .disposed(by: disposeBag)
    }
    
}
