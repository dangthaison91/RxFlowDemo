//
//  Schedule.swift
//  RxFlowDemo
//
//  Created by dangthaison on 12/25/17.
//

import Foundation
import ObjectMapper
import RealmSwift

protocol PaginationResponse {
    associatedtype Element: Object, Mappable
    
    var hasNext: Bool { get set }
    var offset: Int { get set }
    var limit: Int { get set }
    
    var items: List<Element> { get }
}

class Schedules: Object, Mappable, PaginationResponse {

    typealias Element = Schedule

    @objc dynamic var hasNext: Bool = false
    @objc dynamic var offset: Int = 0
    @objc dynamic var limit: Int = 16
    
    let items: List<Schedule> = List<Schedule>()
    
    required convenience init?(map: Map) {
        self.init(map: map)
    }
    
    func mapping(map: Map) {
        
    }
}

class Schedule: Object, Mappable, IdentifiableObject {
    
    typealias Identity = String
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var notes: String = ""

    @objc dynamic var medication: Medication?
    @objc dynamic var dosage: Dosage?

    let times: List<ScheduleTime> = List<ScheduleTime>()
    let takedRecords: List<ScheduleTimeRecord> = List<ScheduleTimeRecord>()

    override class func primaryKey() -> String? { return "id" }

    required convenience init?(map: Map) {
        self.init(map: map)
    }

    func mapping(map: Map) {

    }
}
