//
//  UmbrellaExtendDto.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/23/24.
//

struct UmbrellaExtendDto: Codable {
    let extensionCount: Int

    enum CodingKeys: String, CodingKey {
        case extensionCount = "extension_count"
    }
}
