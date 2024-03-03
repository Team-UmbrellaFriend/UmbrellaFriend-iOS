//
//  MypageDto.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/2/24.
//

import Foundation

struct MypageDto: Codable, Sequence {
    let user: MypageUser
    let history: [History]
    
    func makeIterator() -> IndexingIterator<[History]> {
        return history.makeIterator()
    }
}

struct MypageUser: Codable {
    let id: Int
    let username: String
    let studentID: Int
    let phoneNumber, email: String
}

struct History: Codable {
    let rentalPeriod, rentDate: String

    enum CodingKeys: String, CodingKey {
        case rentalPeriod = "rental_period"
        case rentDate = "rent_date"
    }
}

extension MypageDto {
    
    static func mypageDtoInitValue() -> MypageDto {
        return MypageDto(user: MypageUser(id: 0, username: "", studentID: 0, phoneNumber: "", email: ""), history: [])
    }
}
