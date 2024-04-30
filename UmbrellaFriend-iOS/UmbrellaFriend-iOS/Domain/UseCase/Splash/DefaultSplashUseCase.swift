//
//  DefaultSplashUseCase.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/29/24.
//

import Foundation

import RxSwift
import RxCocoa

final class DefaultSplashUseCase: SplashUseCase {
    
    private let splashRepository: SplashRepository
    
    private let disposeBag = DisposeBag()
    
    init(splashRepository: SplashRepository) {
        self.splashRepository = splashRepository
    }
    
    var versionData = PublishRelay<VersionInfoEntity>()
}

extension DefaultSplashUseCase {
    
    func getVersion() {
        splashRepository.getVersion()
            .subscribe(with: self, onNext: { owner, version in
                owner.versionData.accept(version)
            }).disposed(by: disposeBag)
    }
}
