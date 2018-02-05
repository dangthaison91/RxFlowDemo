//
//  Medication.swift
//  RxFlowDemo
//
//  Created by dangthaison on 12/25/17.
//

import Foundation
import RealmSwift
import ObjectMapper

class Medication: Object, Mappable {

    @objc dynamic var name: String = ""
    @objc dynamic var family: String = ""
    @objc dynamic var information: String = ""

    let dosages: List<Dosage> = List<Dosage>()

    required convenience init?(map: Map) {
        self.init(map: map)
    }

    func mapping(map: Map) {

    }
}
