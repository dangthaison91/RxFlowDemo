//
//  DefaultKeys.swift
//  RxFlowDemo
//
//  Created by dangthaison on 1/2/18.
//

import Foundation

// swiftlint:disable identifier_name
public let Defaults = UserDefaults.standard

private let UserIdKey = "userId"
private let UserLoggedInKey = "UserLoggedIn"
private let ShowInvitationKey = "InvitationScreen"
// swiftlint:enable identifier_name

extension UserDefaults {
    
    var userId: Int {
        get {
            return Defaults.integer(forKey: UserIdKey)
        }
        
        set (newUserId) {
            Defaults.setValue(newUserId, forKey: UserIdKey)
        }
    }
    
    var userLoggedIn: Bool {
        get {
            return Defaults.bool(forKey: UserLoggedInKey)
        }
        
        set {
            Defaults.setValue(newValue, forKey: UserLoggedInKey)
        }
    }
    
}
