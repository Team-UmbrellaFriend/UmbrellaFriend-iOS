//
//  AuthTarget.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/2/24.
//

import Foundation

import Moya

enum AuthTarget {
    
    case postLogin(id: String, pw: String, fcmToken: String)
    case getUserProfile(id: Int)
    case getLogout
    case putUserProfile(id: Int, email: String, pw: String, phone: String)
    case postSignup(username: String, email: String, pw: String, studentId: Int, img: Data, phone: String, fcmToken: String)
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
        case .putUserProfile(id: let id, email: _, pw: _, phone: _):
            let path = URLConstant.userProfile
                .replacingOccurrences(of: "{UserId}", with: String(id))
            return path
        case.postSignup:
            return URLConstant.userSignup
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
        case .postSignup:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self{
        case .postLogin(id: let id, pw: let pw, fcmToken: let fcmToken):
            return .requestParameters(parameters: ["studentID": id, "password": pw, "fcm_token": fcmToken],
                                      encoding: URLEncoding.default)
        case .getUserProfile:
            return .requestPlain
        case .getLogout:
            return .requestPlain
        case .putUserProfile(id: _, email: let email, pw: let pw, phone: let phone):
            let emailData = MultipartFormData(provider: .data(email.data(using: .utf8)!), name: "email")
            let pwData = MultipartFormData(provider: .data(pw.data(using: .utf8)!), name: "password")
            let pwData2 = MultipartFormData(provider: .data(pw.data(using: .utf8)!), name: "password2")
            let phoneData = MultipartFormData(provider: .data(phone.data(using: .ascii)!), name: "profile.phoneNumber")
            return .uploadMultipart([emailData, pwData, pwData2, phoneData])
        case .postSignup(username: let name, email: let email, pw: let pw, studentId: let id, img: let img, phone: let phone, fcmToken: let fcmToken):
            let nameData = MultipartFormData(provider: .data(name.data(using: .utf8)!), name: "username")
            let emailData = MultipartFormData(provider: .data(email.data(using: .utf8)!), name: "email")
            let pwData = MultipartFormData(provider: .data(pw.data(using: .utf8)!), name: "password")
            let pwData2 = MultipartFormData(provider: .data(pw.data(using: .utf8)!), name: "password2")
            let idData = MultipartFormData(provider: .data(id.description.data(using: .ascii)!), name: "profile.studentID")
            let imgData = MultipartFormData(provider: .data(img), name: "profile.studentCard", fileName: "studentCard.jpg", mimeType: "image/jpeg")
            let phoneData = MultipartFormData(provider: .data(phone.data(using: .ascii)!), name: "profile.phoneNumber")
            let fcmData = MultipartFormData(provider: .data(fcmToken.data(using: .utf8)!), name: "fcm_token")
            return .uploadMultipart([nameData, emailData, pwData, pwData2, idData, imgData, phoneData, fcmData])
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
        case .postSignup:
            return nil
        }
    }
}
