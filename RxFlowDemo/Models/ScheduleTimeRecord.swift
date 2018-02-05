//
//  ScheduleTimeRecord.swift
//  RxFlowDemo
//
//  Created by dangthaison on 12/25/17.
//

import Foundation
import RealmSwift
import ObjectMapper

class ScheduleTimeRecord: Object, Mappable {

    @objc dynamic var dosageId: String = ""
    @objc dynamic var medicationId: String = ""
    @objc dynamic var note: String = ""
    @objc dynamic var qty: Int = 0
    @objc dynamic var takenDate: Date?
    @objc dynamic var scheduleTimeId: String = ""
    @objc dynamic var updatedAt: Date?
    @objc dynamic var scheduleTime: ScheduleTime?

    required convenience init?(map: Map) {
        self.init(map: map)
    }

    func mapping(map: Map) {

    }
}
