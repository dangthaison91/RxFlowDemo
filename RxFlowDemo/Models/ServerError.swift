//
//  ServerError.swift
//  RxFlowDemo
//
//  Created by sondt on 12/1/17.
//

import Foundation
import ObjectMapper

struct ServerError: Error {

    /** The HTTP status code generated by the origin server for this occurrence of the problem. */
    var status: Int = 0

    var title: String = ""

    /** A human-readable explanation specific to this occurrence of the problem.
     Don't use this text to analyze error content systematially.
     Because this text can be changed to describe better.
     */
    var message: String = ""

}

extension ServerError: ImmutableMappable {
    init(map: Map) throws {
        title = try map.value("title")
        message = try map.value("demessagetail")
    }
}
