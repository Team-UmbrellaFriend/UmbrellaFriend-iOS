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
    case getLogout
    case putUserProfile(id: Int, email: String, pw: String, phone: String)
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
        case .getLogout:
            return URLConstant.userLogout
        case .putUserProfile(id: let id, email: let email, pw: let pw, phone: let phone):
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
        case .getLogout:
            return .get
        case .putUserProfile:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self{
        case .postLogin(id: let id, pw: let pw):
            return .requestParameters(parameters: ["studentID": id, "password": pw],
                                      encoding: URLEncoding.default)
        case .getUserProfile:
            return .requestPlain
        case .getLogout:
            return .requestPlain
        case .putUserProfile(id: let id, email: let email, pw: let pw, phone: let phone):
            let emailData = MultipartFormData(provider: .data(email.data(using: .utf8)!), name: "eamil")
            let pwData = MultipartFormData(provider: .data(pw.data(using: .utf8)!), name: "password")
            let pwData2 = MultipartFormData(provider: .data(pw.data(using: .utf8)!), name: "password2")
            let phone = MultipartFormData(provider: .data(phone.data(using: .ascii)!), name: "profile.phoneNubmer")
            return .uploadMultipart([emailData, pwData, pwData2, phone])
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .postLogin:
            return nil
        case .getUserProfile:
            return APIConstants.headerWithToken
        case .getLogout:
            return APIConstants.headerWithToken
        case .putUserProfile:
            return APIConstants.headerWithTokenType
        }
    }
}
