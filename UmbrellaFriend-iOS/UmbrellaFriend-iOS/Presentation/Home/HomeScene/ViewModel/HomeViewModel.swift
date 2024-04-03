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
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let extendButtonTapped: Observable<Void>
    }
    
    struct Output {
        var homeData = PublishRelay<HomeEntity>()
        var extendErrorData = PublishRelay<String>()
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.viewWillAppearEvent.subscribe(with: self, onNext: { owner, _ in
            owner.homeUseCase.getHome()
        })
        .disposed(by: disposeBag)
        
//        input.extendButtonTapped.subscribe(with: self, onNext: { owner, _ in
//            owner.getUmbrellaExtendDto()
//        })
//        .disposed(by: disposeBag)
        
        return output
    }
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        homeUseCase.homeData
            .bind(to: output.homeData)
            .disposed(by: disposeBag)
    }
}

//extension HomeViewModel {
//    
//    func getHomeDto(output: Output) {
//        HomeAPI.shared.getHome { [weak self] response in
//            guard (response?.status) != nil else { return }
//            guard self != nil else { return }
//            guard let data = response?.data else { return }
//            output.homeData.accept(data)
//        }
//    }
    
//    func getUmbrellaExtendDto() {
//        UmbrellaAPI.shared.getUmbrellaExtend { [weak self] response in
//            guard (response?.status) != nil else { return }
//            guard self != nil else { return }
//            if response?.status == 200 {
//                guard let data = response?.data else { return }
//                self?.extendData.onNext(data)
//                self?.extendErrorData.onNext("")
//            } else {
//                guard let message = response?.message else { return }
//                self?.extendErrorData.onNext(message)
//            }
//        }
//    }
//}
