//
//  VersionInfoEntity.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/24/24.
//

import Foundation

struct VersionInfoEntity: Codable {
    let iosVersion, androidVersion: Version
    let notificationTitle, notificationContent: String
}

// MARK: - Version
struct Version: Codable {
    let appVersion, forceUpdateVersion: String
}
