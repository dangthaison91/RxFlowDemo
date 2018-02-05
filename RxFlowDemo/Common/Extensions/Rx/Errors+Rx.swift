//
//  Rx+Errors.swift
//  RxFlowDemo
//
//  Created by dangthaison on 12/26/17.
//

import Foundation
import RxSwift
import RxCocoa
import Action

extension ObservableType {
    
    func forwardError<O: ObserverType>(to observer: O) -> Observable<E> where O.E == Error {
        return self.do(onError: { observer.onNext($0) })
    }
}

//// MARK: - Action
//extension ObservableType where E == ActionError {
//    var underlyingError: Observable<Error> {
//        return self.map { $0.underlyingError }.filterNil()
//    }
//}
//
//extension Action {
//    var underlyingError: Observable<Error> {
//        return self.errors.underlyingError
//    }
//}

