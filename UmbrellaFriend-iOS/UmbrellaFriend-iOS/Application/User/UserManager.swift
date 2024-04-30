//
//  UserManager.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/4/24.
//

import Foundation

final class UserManager {
    
    static let shared = UserManager()
    
    @UserDefaultWrapper<String>(key: "token") private(set) var token
    @UserDefaultWrapper<String>(key: "fcmToken") private(set) var fcmToken
    @UserDefaultWrapper<String>(key: "storeVersion") private(set) var storeVersion
    
    var hasToken: Bool { return self.token != nil }
    var getToken: String { return self.token ?? "" }
    var getFcmToken: String { return self.fcmToken ?? "" }
    var getStoreVersion: String { return self.storeVersion ?? "1.0.0" }
    
    private init() {}
}

extension UserManager {
    
    func updateToken(_ token: String) {
        self.token = token
    }
    
    func updateFcmToken(_ fcmToken: String) {
        self.fcmToken = fcmToken
    }
    
    func updateStoreVersion(_ storeVersion: String) {
        self.storeVersion = storeVersion
    }
    
    func clearToken() {
        self.token = nil
    }
}
