//
//  UmbrellaTarget.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/26/24.
//

import Foundation

import Moya

enum UmbrellaTarget {
    
    case getUmbrellaAvailable
    case getUmbrellaCheck(umbrellaNumber: Int)
    case postUmbrellaLend(umbrellaNumber: Int)
}

extension UmbrellaTarget: BaseTargetType {
    
    var path: String {
        switch self{
        case .getUmbrellaAvailable:
            return URLConstant.umbrellaAvailable
        case .getUmbrellaCheck(umbrellaNumber: let umbrellaNumber):
            let path = URLConstant.umbrellaCheck
                .replacingOccurrences(of: "{UmbrellaNumber}", with: String(umbrellaNumber))
            return path
        case .postUmbrellaLend(umbrellaNumber: let umbrellaNumber):
            let path = URLConstant.umbrellaLend
                .replacingOccurrences(of: "{UmbrellaNumber}", with: String(umbrellaNumber))
            return path
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .getUmbrellaAvailable:
            return .get
        case .getUmbrellaCheck:
            return .get
        case .postUmbrellaLend:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self{
        case .getUmbrellaAvailable:
            return .requestPlain
        case .getUmbrellaCheck:
            return .requestPlain
        case .postUmbrellaLend:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .getUmbrellaAvailable:
            return nil
        case .getUmbrellaCheck:
            return APIConstants.headerWithToken
        case .postUmbrellaLend:
            return APIConstants.headerWithToken
        }
    }
}
