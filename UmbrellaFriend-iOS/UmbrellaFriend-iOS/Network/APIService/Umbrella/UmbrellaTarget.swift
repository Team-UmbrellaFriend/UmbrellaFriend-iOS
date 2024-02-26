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
}

extension UmbrellaTarget: BaseTargetType {
    
    var path: String {
        switch self{
        case .getUmbrellaAvailable:
            return URLConstant.umbrellaAvailable
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .getUmbrellaAvailable:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self{
        case .getUmbrellaAvailable:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .getUmbrellaAvailable:
            return nil
        }
    }
}

