//
//  MypageEntity.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/16/24.
//

import Foundation

struct MypageEntity: Codable, Sequence {
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

extension MypageEntity {
    
    static func mypageEntityInitValue() -> MypageEntity {
        return MypageEntity(user: MypageUser(id: 0, username: "", studentID: 0, phoneNumber: "", email: ""), history: [])
    }
}
