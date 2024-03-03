//
//  UserProfileDto.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/2/24.
//

struct UserProfileDto: Codable {
    let id: Int
    let username, email: String
    let profile: Profile
}

struct Profile: Codable {
    let studentID: Int
    let phoneNumber: String
}

extension UserProfileDto {
    
    static func userProfileDtoInitValue() -> UserProfileDto {
        return UserProfileDto(id: 0, username: "", email: "", profile: Profile(studentID: 0, phoneNumber: ""))
    }
}
