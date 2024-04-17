//
//  UmbrellaRentViewModel.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/28/24.
//

import UIKit

import RxSwift
import RxCocoa
import Moya

final class UmbrellaRentViewModel: ViewModelType {
    
    private let umbrellaUseCase: UmbrellaUseCase
    
    init(umbrellaUseCase: UmbrellaUseCase) {
        self.umbrellaUseCase = umbrellaUseCase
    }
    
    struct Input {
        let qrCodeCaptured: Observable<Int>
        let lendButtonTapped: Observable<Int>
    }
    
    struct Output {
        var umbrellaCheckData = PublishRelay<UmbrellaCheckEntity>()
        var umbrellaLendMessage = PublishRelay<String>()
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.qrCodeCaptured
            .subscribe(with: self, onNext: { owner, num in
                owner.umbrellaUseCase.getUmbrellaCheck(umbrellaNum: num)
            })
            .disposed(by: disposeBag)
        
        input.lendButtonTapped
            .subscribe(with: self, onNext: { owner, num in
                owner.umbrellaUseCase.postUmbrellaLend(umbrellaNum: num)
            })
            .disposed(by: disposeBag)
        
        return output
    }
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        umbrellaUseCase.umbrellaCheckData
            .bind(to: output.umbrellaCheckData)
            .disposed(by: disposeBag)
        
        umbrellaUseCase.umbrellaLendData
            .bind(to: output.umbrellaLendMessage)
            .disposed(by: disposeBag)   
    }
}
