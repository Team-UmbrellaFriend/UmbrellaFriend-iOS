//
//  ReportMenuDto.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/23/24.
//

import Foundation

struct ReportMenuDto: Codable {
    let title: String
}

extension ReportMenuDto {
    
    static func reportMenuDtoInitValue() -> [ReportMenuDto] {
        return [ReportMenuDto(title: "우산을 분실했어요"),
                ReportMenuDto(title: "QR코드가 파손되었어요"),
                ReportMenuDto(title: "우산이 부러졌어요")]
    }
}
