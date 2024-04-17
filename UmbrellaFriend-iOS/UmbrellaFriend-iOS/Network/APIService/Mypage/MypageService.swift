//
//  MypageService.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/16/24.
//

import Foundation

import Moya
import RxSwift
import RxMoya

protocol MypageService {
    
    func getMypage() -> Single<MypageEntity>
    func postMypageReport(requestDto: MypageReportRequestDto) -> Single<String>
}

final class DefaultMypageService: NSObject {
    
    private var mypageProvider = MoyaProvider<MypageTarget>(plugins: [NetworkLoggerPlugin()])
}

extension DefaultMypageService: MypageService {
    
    func getMypage() -> Single<MypageEntity> {
        mypageProvider.rx.request(.getMypage)
            .filterSuccessfulStatusCodes()
            .mapGenericResponse(MypageEntity.self)
    }
    
    func postMypageReport(requestDto: MypageReportRequestDto) -> Single<String> {
        mypageProvider.rx.request(.postMypageReport(reportData: requestDto))
            .map { response in
                let genericResponse = try response.map(GeneralResponse<BlankEntity>.self)
                return genericResponse.message
            }
    }
}
