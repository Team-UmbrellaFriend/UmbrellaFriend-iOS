//
//  HomeTarget.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/25/24.
//

import Foundation

import Moya

enum HomeTarget {
    
    case getHome
}

extension HomeTarget: BaseTargetType {
    
    var path: String {
        return URLConstant.home
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return APIConstants.headerWithToken
    }
}
