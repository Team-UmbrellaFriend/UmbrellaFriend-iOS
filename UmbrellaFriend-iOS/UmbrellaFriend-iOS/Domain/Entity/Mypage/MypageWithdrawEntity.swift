//
//  MypageWithdrawEntity.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/24/24.
//

import Foundation

struct MypageWithdrawEntity: Codable {
    let title: String
}

extension MypageWithdrawEntity {
    
    static func mypageWithdrawEntityInitValue() -> [MypageWithdrawEntity] {
        return [MypageWithdrawEntity(title: "우산 수량이 적어서 사용을 잘 안해요."),
                MypageWithdrawEntity(title: "우산 관리가 잘 안되어 사용할 수 없어요."),
                MypageWithdrawEntity(title: "새 계정을 만들고 싶어요.")]
    }
}
