//
//  IdentifiableObject.swift
//
//  Created by Dang Thai Son on 7/24/17.
//

import Foundation
import RealmSwift
import RxSwift

protocol IdentifiableObject {
    associatedtype Identity: Hashable
    var id: Identity { get set }
}

extension IdentifiableObject where Self: Object {
    static func first(id: Self.Identity) -> Self? {
        return DataStore.first(type: self, filter: NSPredicate(format: "id == \(id)"))
    }

    static func object(id: Self.Identity) -> Observable<Self> {
        return DataStore
            .observableObjects(type: self, filter: NSPredicate(format: "id == \(id)"))
            .map { $0.first }
            .filterNil()
    }
}
