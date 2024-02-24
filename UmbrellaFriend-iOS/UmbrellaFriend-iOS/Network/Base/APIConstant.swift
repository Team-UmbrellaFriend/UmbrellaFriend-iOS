//
//  APIConstant.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/25/24.
//

import Foundation

enum NetworkHeaderKey: String {
    
    case authorization = "Authorization"
}

enum APIConstants {
    
    static var token: String = "Token 9a60dd3feb464e27d35ff521cdb52fb974f7e7dd"
    
    //MARK: - Header

    static var headerWithToken: [String: String] {
        [
            NetworkHeaderKey.authorization.rawValue: APIConstants.token
        ]
    }
}
