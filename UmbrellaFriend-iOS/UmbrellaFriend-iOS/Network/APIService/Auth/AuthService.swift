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
    func delWithdraw(requestDto: WithdrawRequestDto) -> Single<String>
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
    
    func delWithdraw(requestDto: WithdrawRequestDto) -> Single<String> {
        authProvider.rx.request(.delWithdraw(withdrawDto: requestDto))
            .map { response in
                let genericResponse = try response.map(GeneralResponse<BlankEntity>.self)
                return genericResponse.message
            }
    }
}
