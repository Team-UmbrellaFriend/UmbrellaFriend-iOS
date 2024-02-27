//
//  UmbrellaAvailableDto.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/26/24.
//

import Foundation

struct UmbrellaAvailableDto: Codable {
    let locationID: Int
    let locationName: String
    let numUmbrellas: Int

    enum CodingKeys: String, CodingKey {
        case locationID = "location_id"
        case locationName = "location_name"
        case numUmbrellas = "num_umbrellas"
    }
}

extension UmbrellaAvailableDto {
    
    static func umbrellaAvailableDtoInitValue() -> UmbrellaAvailableDto {
        return UmbrellaAvailableDto(locationID: 0, locationName: "", numUmbrellas: 0)
    }
}
