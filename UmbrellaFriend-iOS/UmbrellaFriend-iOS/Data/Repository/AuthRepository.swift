//
//  AuthRepository.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/16/24.
//

import Moya
import RxSwift

protocol AuthRepository {
    
    var logoutResult: BlankEntity? { get set }
    
    func getLogout() -> Observable<BlankEntity>
}

final class DefaultAuthRepository {
    
    //MARK: - Dependency
    
    private let authService: AuthService
    static let shared = DefaultAuthRepository(authService: DefaultAuthService())
    
    //MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    var logoutResult: BlankEntity?
    
    //MARK: - Life Cycle
    
    init(authService: AuthService) {
        self.authService = authService
    }
}

extension DefaultAuthRepository: AuthRepository {
    
    func getLogout() -> Observable<BlankEntity> {
        authService.getLogout()
            .do(onSuccess: { [weak self] in self?.logoutResult = $0 } )
            .asObservable()
    }
}
