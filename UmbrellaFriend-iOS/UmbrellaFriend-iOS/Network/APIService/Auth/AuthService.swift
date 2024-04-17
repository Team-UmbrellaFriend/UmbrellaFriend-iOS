//
//  AuthService.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/16/24.
//

import Foundation

import Moya
import RxSwift
import RxMoya

protocol AuthService {
    
    func getLogout() -> Single<BlankEntity>
}

final class DefaultAuthService: NSObject {
    
    private var authProvider = MoyaProvider<AuthTarget>(plugins: [NetworkLoggerPlugin()])
}

extension DefaultAuthService: AuthService {
    
    func getLogout() -> Single<BlankEntity> {
        authProvider.rx.request(.getLogout)
            .filterSuccessfulStatusCodes()
            .mapGenericResponse(BlankEntity.self)
    }
}
