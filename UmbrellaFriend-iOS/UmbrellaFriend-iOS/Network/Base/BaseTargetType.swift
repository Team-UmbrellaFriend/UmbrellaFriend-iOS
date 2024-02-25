//
//  BaseTargetType.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/25/24.
//

import Foundation
import Moya

protocol BaseTargetType: TargetType {}

extension BaseTargetType {
    
    var baseURL: URL {
        return URL(string: URLConstant.baseURL)!
    }
}
