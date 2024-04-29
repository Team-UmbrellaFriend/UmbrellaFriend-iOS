//
//  MypageViewModel.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/2/24.
//

import UIKit

import RxSwift
import RxCocoa
import Moya

final class MypageViewModel: ViewModelType {
    
    private let mypageUseCase: MypageUseCase
    private let authUseCase: AuthUseCase
    
    init(
        mypageUseCase: MypageUseCase,
        authUseCase: AuthUseCase
    ) {
        self.mypageUseCase = mypageUseCase
        self.authUseCase = authUseCase
    }
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let logoutButtonTapped: Observable<Void>
        let reportButtonTapped: Observable<MypageReportRequestDto>
        let withdrawButtonTapped: Observable<WithdrawRequestDto>
    }
    
    struct Output {
        var mypageData = PublishRelay<MypageEntity>()
        var logoutData = PublishRelay<BlankEntity>()
        var mypageReportData = PublishRelay<String>()
        var withdrawData = PublishRelay<String>()
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.viewWillAppearEvent.subscribe(with: self, onNext: { owner, _ in
            owner.mypageUseCase.getMypage()
        })
        .disposed(by: disposeBag)
        
        input.logoutButtonTapped.subscribe(with: self, onNext: { owner, _ in
            owner.authUseCase.getLogout()
        })
        .disposed(by: disposeBag)
        
        input.reportButtonTapped.subscribe(with: self, onNext: { owner, dto in
            owner.mypageUseCase.postMypageReport(requestDto: dto)
        })
        .disposed(by: disposeBag)
        
        input.withdrawButtonTapped.subscribe(with: self, onNext: { owner, dto in
            owner.authUseCase.delWithdraw(requestDto: dto)
        })
        .disposed(by: disposeBag)
        
        return output
    }
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        mypageUseCase.mypageData
            .bind(to: output.mypageData)
            .disposed(by: disposeBag)
        
        authUseCase.logoutData
            .bind(to: output.logoutData)
            .disposed(by: disposeBag)
        
        mypageUseCase.mypageReportData
            .bind(to: output.mypageReportData)
            .disposed(by: disposeBag)
        
        authUseCase.withdrawMessage
            .bind(to: output.withdrawData)
            .disposed(by: disposeBag)
    }
}
