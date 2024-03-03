//
//  MypageTarget.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/2/24.
//

import Foundation

import Moya

enum MypageTarget {
    
    case getMypage
}

extension MypageTarget: BaseTargetType {
    
    var path: String {
        return URLConstant.mypage
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
