//
//  DefaultMypageUseCase.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/16/24.
//

import RxSwift
import RxCocoa

final class DefaultMypageUseCase: MypageUseCase {
    
    private let mypageRepository: MypageRepository
    
    private let disposeBag = DisposeBag()
    
    init(mypageRepository: MypageRepository) {
        self.mypageRepository = mypageRepository
    }
    
    var mypageData = PublishRelay<MypageEntity>()
}

extension DefaultMypageUseCase {
    
    func getMypage() {
        mypageRepository.getMypage()
            .subscribe(with: self, onNext: { owner, mypage in
                owner.mypageData.accept(mypage)
            }).disposed(by: disposeBag)
    }
}
