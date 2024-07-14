//
//  RentWidgetDto.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 7/5/24.
//

import Foundation

struct RentWidgetDto: Codable {
    let isRent: Bool
    let isOverdue: Bool
    let returnDay: Int
}
