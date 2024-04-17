//
//  UmbrellaMapViewModel.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/26/24.
//

import UIKit

import RxSwift
import RxCocoa
import Moya

final class UmbrellaMapViewModel: ViewModelType {
    
    private let umbrellaUseCase: UmbrellaUseCase
    
    init(umbrellaUseCase: UmbrellaUseCase) {
        self.umbrellaUseCase = umbrellaUseCase
    }
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let mapIconTapped: Observable<Int>
    }
    
    struct Output {
        var umbrellaAvailableData = PublishRelay<[UmbrellaAvailableEntity]>()
        var umbrellaMapData = PublishRelay<UmbrellaAvailableEntity>()
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.viewWillAppearEvent
            .subscribe(with: self, onNext: { owner, _ in
                owner.umbrellaUseCase.getUmbrellaAvailable()
            })
            .disposed(by: disposeBag)
        
        input.mapIconTapped
            .withLatestFrom(umbrellaUseCase.umbrellaAvailableData) { index, data in
                return data[index]
            }
            .bind(to: output.umbrellaMapData)
            .disposed(by: disposeBag)
        
        return output
    }
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        umbrellaUseCase.umbrellaAvailableData
            .bind(to: output.umbrellaAvailableData)
            .disposed(by: disposeBag)
    }
}
