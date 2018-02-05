//
//  Dosage.swift
//  RxFlowDemo
//
//  Created by dangthaison on 12/25/17.
//

import Foundation
import RealmSwift
import ObjectMapper

class Dosage: Object, Mappable {

    @objc dynamic var name: String = ""
    @objc dynamic var information: String = ""
    @objc dynamic var value: String = ""
    @objc dynamic var maxDaily: Int = 0
    @objc dynamic var maxSingle: Int = 0

    required convenience init?(map: Map) {
        self.init(map: map)
    }

    func mapping(map: Map) {

    }
}
