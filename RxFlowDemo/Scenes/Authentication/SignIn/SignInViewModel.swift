//
//  SignInViewModel.swift
//  MyHealthPal-Playground
//
//  Created by sondt on 12/1/17.
//

import Foundation
import RxSwift
import RxFlow

class SignInViewModel: SignInViewModelType, Stepper {
    
    let signInTrigger: PublishSubject<Void> = PublishSubject<Void>()
    
    // Private
    private let disposeBag = DisposeBag()
    
    init() {
        let signResult = signInTrigger
            .subscribe(onNext: { [unowned self] in
                self.step.accept(LaunchStep.home)
            })
            .disposed(by: disposeBag)
    }
}
