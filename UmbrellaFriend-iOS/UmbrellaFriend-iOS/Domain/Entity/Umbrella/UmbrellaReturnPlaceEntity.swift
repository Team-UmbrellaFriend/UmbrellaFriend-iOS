//
//  UmbrellaReturnPlaceEntity.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/21/24.
//

import Foundation

struct UmbrellaReturnPlaceEntity: Codable {
    let placeImage: String
    let placeTitle: String
}

extension UmbrellaReturnPlaceEntity {
    
    static func umbrellaReturnPlace() -> [UmbrellaReturnPlaceEntity] {
        return [
            UmbrellaReturnPlaceEntity(placeImage: "img_myungsin", placeTitle: "명신관"),
            UmbrellaReturnPlaceEntity(placeImage: "img_renaissance", placeTitle: "르네상스관"),
            UmbrellaReturnPlaceEntity(placeImage: "img_science", placeTitle: "과학관"),
            UmbrellaReturnPlaceEntity(placeImage: "img_art", placeTitle: "미술대학")
        ]
    }
}
