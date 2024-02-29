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
    case postUmbrellaReturn(location: String, data: Data)
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
        case .postUmbrellaReturn:
            return URLConstant.umbrellaReturn
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
        case .postUmbrellaReturn:
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
        case .postUmbrellaReturn(location: let location, data: let data):
            let locationData = MultipartFormData(provider: .data(location.data(using: .utf8)!), name: "location")
            let imgData = MultipartFormData(provider: .data(data), name: "return_image", fileName: "img.jpg", mimeType: "image/jpg")
            return .uploadMultipart([locationData, imgData])
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
        case .postUmbrellaReturn:
            return APIConstants.headerWithToken
        }
    }
}
