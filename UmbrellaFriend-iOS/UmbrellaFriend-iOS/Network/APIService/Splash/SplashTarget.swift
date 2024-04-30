//
//  SplashTarget.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/29/24.
//

import Foundation

import Moya

enum SplashTarget {
    
    case getVersion
}

extension SplashTarget: BaseTargetType {
    
    var path: String {
        return URLConstant.versionInfo
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
