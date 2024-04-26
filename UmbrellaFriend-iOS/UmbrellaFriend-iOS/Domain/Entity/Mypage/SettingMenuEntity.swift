//
//  SettingMenuEntity.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/25/24.
//

import RxDataSources

struct SettingMenuEntity {
    let settingTitle: String
}

extension SettingMenuEntity {
    
    static func settingSupportValue() -> [SettingMenuEntity] {
        return [SettingMenuEntity(settingTitle: "신고하기"),
                SettingMenuEntity(settingTitle: "버전"),
                SettingMenuEntity(settingTitle: "서비스 이용약관"),
                SettingMenuEntity(settingTitle: "개인 정보 처리 방침")]
    }
    
    static func settingAccountValue() -> [SettingMenuEntity] {
        return [SettingMenuEntity(settingTitle: "로그아웃"),
                SettingMenuEntity(settingTitle: "탈퇴하기")]
    }
}
