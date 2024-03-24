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
    case postMypageReport(umbrellaNum: Int, reportReason: String, description: String)
}

extension MypageTarget: BaseTargetType {
    
    var path: String {
        switch self {
        case .getMypage:
            return URLConstant.mypage
        case .postMypageReport:
            return URLConstant.mypageReport
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMypage:
            return .get
        case .postMypageReport:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMypage:
            return .requestPlain
        case .postMypageReport(umbrellaNum: let umbrellaNum, reportReason: let reportReason, description: let description):
            let umbrellaNumData = MultipartFormData(provider: .data(umbrellaNum.description.data(using: .ascii)!), name: "umbrella_number")
            let reportReasonData = MultipartFormData(provider: .data(reportReason.data(using: .utf8)!), name: "report_reason")
            let descriptionData = MultipartFormData(provider: .data(description.data(using: .utf8)!), name: "description")
            return .uploadMultipart([umbrellaNumData, reportReasonData, descriptionData])
        }
    }
    
    var headers: [String : String]? {
        return APIConstants.headerWithToken
    }
}
