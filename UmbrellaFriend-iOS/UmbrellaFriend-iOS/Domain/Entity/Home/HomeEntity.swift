//
//  HomeEntity.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/25/24.
//

import Foundation

struct HomeEntity: Codable {
    let user: User
    let weather: HomeWeather
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

struct HomeWeather: Codable {
    let weather: Weather
    let message: String
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

extension HomeEntity {
    
    static func homeDtoInitValue() -> HomeEntity {
        return HomeEntity(user: User(id: 0, username: ""), weather: HomeWeather(weather: Weather(date: "", percent: ""), message: ""), dDay: DDay(isOverdue: false, overdueDays: 0, daysRemaining: 0))
    }
}
