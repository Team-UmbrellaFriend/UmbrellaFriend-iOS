//
//  UmbrellaReturnViewModel.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

import RxSwift
import RxCocoa
import Moya

final class UmbrellaReturnViewModel: ViewModelType {
    
    private let umbrellaUseCase: UmbrellaUseCase
    
    init(umbrellaUseCase: UmbrellaUseCase) {
        self.umbrellaUseCase = umbrellaUseCase
    }
    
    struct Input {
        let returnQrCodeCaptured: Observable<UmbrellaReturnRequestDto>
    }
    
    struct Output {
        var umbrellaReturnCode = PublishRelay<Int>()
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.returnQrCodeCaptured
            .subscribe(with: self, onNext: { owner, dto in
                owner.umbrellaUseCase.postUmbrellaReturn(requestDto: dto)
            })
            .disposed(by: disposeBag)
        
        return output
    }
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        umbrellaUseCase.umbrellaReturnData
            .bind(to: output.umbrellaReturnCode)
            .disposed(by: disposeBag)
    }
}
