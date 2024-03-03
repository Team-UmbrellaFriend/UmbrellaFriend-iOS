//
//  AuthTarget.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/2/24.
//

import Foundation

import Moya

enum AuthTarget {
    
    case postLogin(id: String, pw: String)
    case getUserProfile(id: Int)
}

extension AuthTarget: BaseTargetType {
    
    var path: String {
        switch self{
        case .postLogin:
            return URLConstant.userLogin
        case .getUserProfile(id: let id):
            let path = URLConstant.userProfile
                .replacingOccurrences(of: "{UserId}", with: String(id))
            return path
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .postLogin:
            return .post
        case .getUserProfile:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self{
        case .postLogin(id: let id, pw: let pw):
            return .requestParameters(parameters: ["studentID": id, "password": pw],
                                      encoding: URLEncoding.default)
        case .getUserProfile:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .postLogin:
            return nil
        case .getUserProfile:
            return APIConstants.headerWithToken
        }
    }
}
