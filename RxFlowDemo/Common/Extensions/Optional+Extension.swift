//
//  Optional+Extension.swift
//  RxFlowDemo
//
//  Created by dangthaison on 12/27/17.
//
// https://gist.github.com/PaulTaykalo/2ebfe0d7c1ca9fff1938506e910f738c

import Foundation
import RxOptional

extension Optional {
    func `or`(_ value: Wrapped?) -> Optional {
        return self ?? value
    }
    func `or`(_ value: Wrapped) -> Wrapped {
        return self ?? value
    }
}

