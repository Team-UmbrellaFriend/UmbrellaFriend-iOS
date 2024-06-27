//
//  AppGroupUserDefaults.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 6/25/24.
//

import Foundation

extension UserDefaults {
    static var groupShared: UserDefaults {
        let appGroupID = "group.org.UmbrellaFriend.UmbrellaFriend-iOS"
        return UserDefaults(suiteName: appGroupID)!
    }
}
