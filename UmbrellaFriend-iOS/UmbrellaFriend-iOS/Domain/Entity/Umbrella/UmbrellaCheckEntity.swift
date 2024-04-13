//
//  UmbrellaCheckEntity.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/13/24.
//

import Foundation

struct UmbrellaCheckEntity: Codable {
    let umbrellaNum: Int
    let username: String
    let studentID: Int
    let date: String

    enum CodingKeys: String, CodingKey {
        case umbrellaNum = "umbrella_num"
        case username, studentID, date
    }
}

extension UmbrellaCheckEntity {
    
    static func umbrellaCheckInitValue() -> UmbrellaCheckEntity {
        return UmbrellaCheckEntity(umbrellaNum: 0, username: "", studentID: 0, date: "")
    }
}
