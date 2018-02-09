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
        signInTrigger
            .subscribe(onNext: { [unowned self] in
                self.step.accept(AppStep.home)
            })
            .disposed(by: disposeBag)
    }
}
