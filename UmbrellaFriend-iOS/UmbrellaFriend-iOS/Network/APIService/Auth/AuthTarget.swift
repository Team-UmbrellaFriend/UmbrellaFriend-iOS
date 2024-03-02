//
//  AuthTarget.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/2/24.
//

import Foundation

import Moya

enum AuthTarget {
    
    case getUserProfile(id: Int)
}

extension AuthTarget: BaseTargetType {
    
    var path: String {
        switch self{
        case .getUserProfile(id: let id):
            let path = URLConstant.userProfile
                .replacingOccurrences(of: "{UserId}", with: String(id))
            return path
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .getUserProfile:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self{
        case .getUserProfile:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .getUserProfile:
            return APIConstants.headerWithToken
        }
    }
}
