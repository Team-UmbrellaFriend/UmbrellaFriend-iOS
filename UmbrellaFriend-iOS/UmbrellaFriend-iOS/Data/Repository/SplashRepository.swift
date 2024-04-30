//
//  SplashRepository.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/29/24.
//

import Moya
import RxSwift

protocol SplashRepository {
    
    var versionResult: VersionInfoEntity? { get set }
    
    func getVersion() -> Observable<VersionInfoEntity>
}

final class DefaultSplashRepository {
    
    //MARK: - Dependency
    
    private let splashService: SplashService
    static let shared = DefaultSplashRepository(splashService: DefaultSplashService())
    
    //MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    var versionResult: VersionInfoEntity?
    
    //MARK: - Life Cycle
    
    init(splashService: SplashService) {
        self.splashService = splashService
    }
}

extension DefaultSplashRepository: SplashRepository {
    
    func getVersion() -> Observable<VersionInfoEntity> {
        splashService.getVersion()
            .do(onSuccess: { [weak self] in self?.versionResult = $0 } )
            .asObservable()
    }
}
