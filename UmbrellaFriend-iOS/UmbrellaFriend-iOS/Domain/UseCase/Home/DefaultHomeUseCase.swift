//
//  DefaultHomeUseCase.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/1/24.
//

import RxSwift
import RxCocoa

final class DefaultHomeUseCase: HomeUseCase {
    
    private let homeRepository: HomeRepository
    
    private let disposeBag = DisposeBag()
    
    init(homeRepository: HomeRepository) {
        self.homeRepository = homeRepository
    }
    
    var homeData = PublishRelay<HomeEntity>()
}

extension DefaultHomeUseCase {
    
    func getHome() {
        homeRepository.getHome()
            .subscribe(with: self, onNext: { owner, home in
                owner.homeData.accept(home)
            }).disposed(by: disposeBag)
    }
}
