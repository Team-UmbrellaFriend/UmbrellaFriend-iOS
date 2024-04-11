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
}

extension DefaultUmbrellaUseCase {
    
    func getUmbrellaExtend() {
        umbrellaRepository.getUmbrellaExtend()
            .subscribe(with: self, onNext: { owner, umbrellaExtend in
                owner.umbrellaExtendData.accept(umbrellaExtend)
            }).disposed(by: disposeBag)
    }
}
