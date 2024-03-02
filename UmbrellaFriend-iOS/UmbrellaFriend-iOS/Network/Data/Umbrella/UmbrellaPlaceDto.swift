//
//  UmbrellaPlaceDto.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

struct UmbrellaPlaceDto: Codable {
    let placeImage: String
    let placeTitle: String
}

extension UmbrellaPlaceDto {
    
    static func umbrellaPlaceDto() -> [UmbrellaPlaceDto] {
        return [
            UmbrellaPlaceDto(placeImage: "img_myungsin", placeTitle: "명신관"),
            UmbrellaPlaceDto(placeImage: "img_soonhun", placeTitle: "순헌관"),
            UmbrellaPlaceDto(placeImage: "img_library", placeTitle: "중앙도서관"),
            UmbrellaPlaceDto(placeImage: "img_soonhun", placeTitle: "학생회관"),
            UmbrellaPlaceDto(placeImage: "img_music", placeTitle: "음악대학"),
            UmbrellaPlaceDto(placeImage: "img_onehundred", placeTitle: "백주년기념관")
        ]
    }
}
