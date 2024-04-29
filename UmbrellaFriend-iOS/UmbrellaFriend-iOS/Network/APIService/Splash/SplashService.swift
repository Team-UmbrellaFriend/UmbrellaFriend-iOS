//
//  SplashService.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/29/24.
//

import Foundation

import Moya
import RxSwift
import RxMoya

protocol SplashService {
    
    func getVersion() -> Single<VersionInfoEntity>
}

final class DefaultSplashService: NSObject {
    
    private var splashProvider = MoyaProvider<SplashTarget>(plugins: [NetworkLoggerPlugin()])
}

extension DefaultSplashService: SplashService {
    
    func getVersion() -> Single<VersionInfoEntity> {
        splashProvider.rx.request(.getVersion)
            .filterSuccessfulStatusCodes()
            .mapGenericResponse(VersionInfoEntity.self)
    }
}
