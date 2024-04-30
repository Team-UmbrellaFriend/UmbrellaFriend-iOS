//
//  DefaultAuthUseCase.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/16/24.
//

import RxSwift
import RxCocoa

final class DefaultAuthUseCase: AuthUseCase {
    
    private let authRepository: AuthRepository
    
    private let disposeBag = DisposeBag()
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    var logoutData = PublishRelay<BlankEntity>()
    var withdrawMessage = PublishRelay<String>()
}

extension DefaultAuthUseCase {
    
    func getLogout() {
        authRepository.getLogout()
            .subscribe(with: self, onNext: { owner, logout in
                owner.logoutData.accept(logout)
            }).disposed(by: disposeBag)
    }
    
    func delWithdraw(requestDto: WithdrawRequestDto) {
        authRepository.delWithdraw(requestDto: requestDto)
            .subscribe(with: self, onNext: { owner, withdraw in
                owner.withdrawMessage.accept(withdraw)
            }).disposed(by: disposeBag)
    }
}
