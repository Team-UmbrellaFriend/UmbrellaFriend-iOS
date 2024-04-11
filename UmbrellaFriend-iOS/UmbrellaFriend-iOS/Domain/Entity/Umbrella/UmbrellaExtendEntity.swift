//
//  UmbrellaExtendEntity.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/3/24.
//

import Foundation

struct UmbrellaExtendEntity: Codable {
    let extensionCount: Int

    enum CodingKeys: String, CodingKey {
        case extensionCount = "extension_count"
    }
}
