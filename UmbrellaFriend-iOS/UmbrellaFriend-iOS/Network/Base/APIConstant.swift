//
//  APIConstant.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/25/24.
//

import Foundation

enum NetworkHeaderKey: String {
    
    case contentType = "Content-Type"
    case authorization = "Authorization"
}

enum APIConstants {
    
    static var type: String = "multipart/form-data"
    
    //MARK: - Header

    static var headerWithToken: [String: String] {
        [
            NetworkHeaderKey.authorization.rawValue: "Token \(UserManager.shared.getToken)"
        ]
    }
    
    static var headerWithTokenType: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: APIConstants.type,
            NetworkHeaderKey.authorization.rawValue: "Token \(UserManager.shared.getToken)"
        ]
    }
}
