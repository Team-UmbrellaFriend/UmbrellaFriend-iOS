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
    
    var hasToken: Bool { return self.token != nil }
    var getToken: String { return self.token ?? "" }
    
    private init() {}
}

extension UserManager {
    
    func updateToken(_ token: String) {
        self.token = token
    }
    
    func clearToken() {
        self.token = nil
    }
}
