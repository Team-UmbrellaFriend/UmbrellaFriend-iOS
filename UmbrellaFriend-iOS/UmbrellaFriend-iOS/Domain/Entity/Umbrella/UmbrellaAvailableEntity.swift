//
//  UmbrellaAvailableEntity.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/12/24.
//

import Foundation

struct UmbrellaAvailableEntity: Codable {
    let locationID: Int
    let locationName, locationDetail: String
    let numUmbrellas: Int

    enum CodingKeys: String, CodingKey {
        case locationID = "location_id"
        case locationName = "location_name"
        case locationDetail = "location_detail"
        case numUmbrellas = "num_umbrellas"
    }
}
