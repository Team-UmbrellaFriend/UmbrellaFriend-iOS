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
    case postMypageReport(reportData: MypageReportRequestDto)
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
        case .postMypageReport(reportData: let reportData):
            let umbrellaNumData = MultipartFormData(provider: .data(reportData.umbrellaNumber.data(using: .ascii)!), name: "umbrella_number")
            let reportReasonData = MultipartFormData(provider: .data(reportData.reportReason.data(using: .utf8)!), name: "report_reason")
            let descriptionData = MultipartFormData(provider: .data(reportData.description.data(using: .utf8)!), name: "description")
            return .uploadMultipart([umbrellaNumData, reportReasonData, descriptionData])
        }
    }
    
    var headers: [String : String]? {
        return APIConstants.headerWithToken
    }
}
