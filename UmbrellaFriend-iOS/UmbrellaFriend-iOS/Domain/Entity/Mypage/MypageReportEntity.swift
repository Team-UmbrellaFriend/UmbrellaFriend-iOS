//
//  MypageReportEntity.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/17/24.
//

import Foundation

struct MypageReportEntity: Codable {
    let title: String
}

extension MypageReportEntity {
    
    static func mypageReportEntityInitValue() -> [MypageReportEntity] {
        return [MypageReportEntity(title: "우산을 분실했어요"),
                MypageReportEntity(title: "QR코드가 파손되었어요"),
                MypageReportEntity(title: "우산이 부러졌어요")]
    }
}
