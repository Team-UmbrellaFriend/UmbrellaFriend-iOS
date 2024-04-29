//
//  SplahViewModel.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/29/24.
//

import UIKit

import RxSwift
import RxCocoa
import Moya

final class SplashViewModel: ViewModelType {
    
    private let splashUseCase: SplashUseCase
    
    init(
        splashUseCase: SplashUseCase
    ) {
        self.splashUseCase = splashUseCase
    }
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
    }
    
    struct Output {
        var versionData = PublishRelay<VersionInfoEntity>()
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.viewWillAppearEvent.subscribe(with: self, onNext: { owner, _ in
            owner.splashUseCase.getVersion()
        })
        .disposed(by: disposeBag)
        
        return output
    }
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        splashUseCase.versionData
            .bind(to: output.versionData)
            .disposed(by: disposeBag)
    }
}
