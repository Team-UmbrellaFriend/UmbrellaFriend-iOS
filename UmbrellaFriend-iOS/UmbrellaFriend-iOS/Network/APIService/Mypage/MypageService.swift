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
}
