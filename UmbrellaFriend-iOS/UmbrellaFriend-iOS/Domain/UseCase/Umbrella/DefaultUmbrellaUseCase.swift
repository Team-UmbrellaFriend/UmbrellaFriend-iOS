//
//  DefaultUmbrellaUseCase.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/11/24.
//

import RxSwift
import RxCocoa

final class DefaultUmbrellaUseCase: UmbrellaUseCase {
    
    private let umbrellaRepository: UmbrellaRepository
    
    private let disposeBag = DisposeBag()
    
    init(umbrellaRepository: UmbrellaRepository) {
        self.umbrellaRepository = umbrellaRepository
    }
    
    var umbrellaExtendData = PublishRelay<String>()
    var umbrellaAvailableData = PublishRelay<[UmbrellaAvailableEntity]>()
    var umbrellaMapTappedData = PublishRelay<UmbrellaAvailableEntity>()
    var umbrellaCheckData = PublishRelay<UmbrellaCheckEntity>()
    var umbrellaLendData = PublishRelay<String>()
}

extension DefaultUmbrellaUseCase {
    
    func getUmbrellaExtend() {
        umbrellaRepository.getUmbrellaExtend()
            .subscribe(with: self, onNext: { owner, umbrellaExtend in
                owner.umbrellaExtendData.accept(umbrellaExtend)
            }).disposed(by: disposeBag)
    }
    
    func getUmbrellaAvailable() {
        umbrellaRepository.getUmbrellaAvailabe()
            .subscribe(with: self, onNext: { owner, umbrellaAvailable in
                owner.umbrellaAvailableData.accept(umbrellaAvailable)
            }).disposed(by: disposeBag)
    }
    
    func getUmbrellaCheck(umbrellaNum: Int) {
        umbrellaRepository.getUmbrellaCheck(umbrellaNum: umbrellaNum)
            .subscribe(with: self, onNext: { owner, umbrellaCheck in
                owner.umbrellaCheckData.accept(umbrellaCheck)
            }).disposed(by: disposeBag)
    }
    
    func postUmbrellaLend(umbrellaNum: Int) {
        umbrellaRepository.postUmbrellaLend(umbrellaNum: umbrellaNum)
            .subscribe(with: self, onNext: { owner, umbrellaLend in
                owner.umbrellaLendData.accept(umbrellaLend)
            }).disposed(by: disposeBag)
    }
}
