//
//  URLConstant.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/25/24.
//

import Foundation

enum URLConstant {
    
    // MARK: - Base URL
    
    static let baseURL = Config.baseURL
    
    // MARK: - URL Path
    
    // home

    static let home = "/home/"
    
    // mypage
    
    static let mypage = "/mypage/"
    static let mypageReport = "/mypage/report/"
    
    // umbrella
    
    static let umbrellaAvailable = "/umbrella/available/"
    static let umbrellaCheck = "/umbrella/{UmbrellaNumber}/check/"
    static let umbrellaLend = "/umbrella/{UmbrellaNumber}/lend/"
    static let umbrellaReturn = "/umbrella/return/"
    static let umbrellaExtend = "/umbrella/extend/"
    
    // users
    
    static let userSignup = "/users/signup/"
    static let userLogin = "/users/login/"
    static let userLogout = "/users/logout/"
    static let userProfile = "/users/profile/{UserId}/"
}
