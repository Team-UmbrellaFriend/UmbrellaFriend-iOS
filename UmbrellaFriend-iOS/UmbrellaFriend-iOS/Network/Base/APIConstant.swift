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
    static var token: String = "Token 377c0d6513943714730e76c83ee7ad2ebd6fdb2b"
    
    //MARK: - Header

    static var headerWithToken: [String: String] {
        [
            NetworkHeaderKey.authorization.rawValue: APIConstants.token
        ]
    }
    
    static var headerWithTokenType: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: APIConstants.type,
            NetworkHeaderKey.authorization.rawValue: APIConstants.token
        ]
    }
}
