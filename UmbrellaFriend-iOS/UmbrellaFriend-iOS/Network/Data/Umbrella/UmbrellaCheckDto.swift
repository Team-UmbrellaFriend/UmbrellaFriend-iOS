//
//  UmbrellaCheckDto.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/28/24.
//

struct UmbrellaCheckDto: Codable {
    let umbrellaNum: Int
    let username: String
    let studentID: Int
    let date: String

    enum CodingKeys: String, CodingKey {
        case umbrellaNum = "umbrella_num"
        case username, studentID, date
    }
}

extension UmbrellaCheckDto {
    
    static func umbrellaCheckDtoInitValue() -> UmbrellaCheckDto {
        return UmbrellaCheckDto(umbrellaNum: 0, username: "", studentID: 0, date: "")
    }
}
