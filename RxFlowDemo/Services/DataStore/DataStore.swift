//
//  DataStore.swift
//
//  Created by Dang Thai Son on 7/5/17.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

class DataStore {

    class var realm: Realm {
        do {
            let realm = try Realm()
            return realm
        } catch let error {
            fatalError(String(describing: error))
        }
    }

    class func objects<T: Object>(type: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }

    class func first<T: Object>(type: T.Type, filter predicate: NSPredicate) -> T? {
        return objects(type: type, filter: predicate).first
    }

    class func objects<T: Object>(type: T.Type, filter predicate: NSPredicate) -> Results<T> {
        return realm.objects(T.self).filter(predicate)
    }

    class func observableObjects<T: Object>(type: T.Type) -> Observable<Results<T>> {
        return Observable.collection(from: realm.objects(T.self)).asObservable()
    }

    class func observableObjects<T: Object>(type: T.Type, filter predicate: NSPredicate) -> Observable<Results<T>> {
        return Observable.collection(from: realm.objects(T.self).filter(predicate)).asObservable()
    }

    class func create(object: Object, update: Bool = false) {
        tryOrLogError { realm.add(object, update: update) }
    }

    class func create(objects: [Object], update: Bool = false) {
        tryOrLogError { realm.add(objects, update: update) }
    }

    class func create<T: Object>(_ type: T.Type, value: Any, update: Bool = false) {
        tryOrLogError { realm.create(T.self, value: value, update: update) }
    }

    class func delete<T: RealmSwift.Object>(object: T) {
        tryOrLogError { realm.delete(object) }
    }

    class func delete(objects: RealmSwift.Results<Object>) {
        tryOrLogError { realm.delete(objects) }
    }

    class func delete(objects: RealmSwift.List<Object>) {
        tryOrLogError { realm.delete(objects) }
    }

    class func update(block: @escaping () -> Void) {
        tryOrLogError { block() }
    }

    private class func tryOrLogError(_ block: (() throws -> Void)) {
        do {
            try realm.write {
                try block()
            }
        } catch {
            print(error)
        }
    }
}
