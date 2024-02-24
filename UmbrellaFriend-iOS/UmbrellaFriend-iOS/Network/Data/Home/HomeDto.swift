//
//  HomeDto.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/25/24.
//

import Foundation

struct HomeDto: Codable {
    let user: User
    let weather: Weather
    let dDay: DDay

    enum CodingKeys: String, CodingKey {
        case user, weather
        case dDay = "d-day"
    }
}

struct User: Codable {
    let id: Int
    let username: String
}

struct Weather: Codable {
    let date, percent: String
}

struct DDay: Codable {
    let isOverdue: Bool
    let overdueDays, daysRemaining: Int

    enum CodingKeys: String, CodingKey {
        case isOverdue = "is_overdue"
        case overdueDays = "overdue_days"
        case daysRemaining = "days_remaining"
    }
}

extension HomeDto {
    
    static func homeDtoInitValue() -> HomeDto {
        return HomeDto(user: User(id: 0, username: ""), weather: Weather(date: "", percent: ""), dDay: DDay(isOverdue: false, overdueDays: 0, daysRemaining: 0))
    }
}
