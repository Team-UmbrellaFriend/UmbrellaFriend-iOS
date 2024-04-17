//
//  HomeViewModel.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/25/24.
//

import UIKit

import RxSwift
import RxCocoa
import Moya

final class HomeViewModel: ViewModelType {
    
    private let homeUseCase: HomeUseCase
    private let umbrellaUseCase: UmbrellaUseCase
    
    init(
        homeUseCase: HomeUseCase,
        umbrellaUseCase: UmbrellaUseCase
    ) {
        self.homeUseCase = homeUseCase
        self.umbrellaUseCase = umbrellaUseCase
    }
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let extendButtonTapped: Observable<Void>
    }
    
    struct Output {
        var homeData = PublishRelay<HomeEntity>()
        var extendMessageData = PublishRelay<String>()
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.viewWillAppearEvent.subscribe(with: self, onNext: { owner, _ in
            owner.homeUseCase.getHome()
        })
        .disposed(by: disposeBag)
        
        input.extendButtonTapped.subscribe(with: self, onNext: { owner, _ in
            owner.umbrellaUseCase.getUmbrellaExtend()
        })
        .disposed(by: disposeBag)
        
        return output
    }
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        homeUseCase.homeData
            .bind(to: output.homeData)
            .disposed(by: disposeBag)
        
        umbrellaUseCase.umbrellaExtendData
            .subscribe(onNext: { message in
                output.extendMessageData.accept(message)
            })
            .disposed(by: disposeBag)
    }
}
