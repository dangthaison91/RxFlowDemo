//
//  ScheduleTime.swift
//  RxFlowDemo
//
//  Created by dangthaison on 12/25/17.
//

import Foundation
import RealmSwift
import ObjectMapper
import SwiftDate

extension WeekDay: RealmCollectionValue {
    
}

class ScheduleTime: Object, Mappable {

    @objc dynamic var id: String = ""
    @objc dynamic var typeRawValue: String = ""
    @objc dynamic var date: Date?
    @objc dynamic var time: Date?
    
    let days: List<WeekDay> = List<WeekDay>()
    
    override class func primaryKey() -> String? { return "id" }

    required convenience init?(map: Map) {
        self.init(map: map)
    }

    func mapping(map: Map) {

    }
}

extension ScheduleTime {
    var type: ScheduleDateType? {
        get {
            return ScheduleDateType(rawValue: typeRawValue)
        }
        set {
            return typeRawValue = newValue?.rawValue ?? ""
        }
    }
}
