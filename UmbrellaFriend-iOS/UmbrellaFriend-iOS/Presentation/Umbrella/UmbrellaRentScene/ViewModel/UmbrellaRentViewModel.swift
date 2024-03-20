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

protocol UmbrellaRentViewModelInputs {
    
    func umbrellaCheck(number: Int)
    func umbrellaLend(number: Int)
}

protocol UmbrellaRentViewModelOutputs {
    
    var umbrellaCheckData: BehaviorRelay<UmbrellaCheckDto> { get }
    var umbrellaLendData: BehaviorRelay<UmbrellaLendDto> { get }
    var lendErrorMessage: PublishSubject<String> { get }
}

protocol UmbrellaRentViewModelType {
    
    var inputs: UmbrellaRentViewModelInputs { get }
    var outputs: UmbrellaRentViewModelOutputs { get }
}

final class UmbrellaRentViewModel: UmbrellaRentViewModelInputs, UmbrellaRentViewModelOutputs, UmbrellaRentViewModelType {
    
    var inputs: UmbrellaRentViewModelInputs { return self }
    var outputs: UmbrellaRentViewModelOutputs { return self }
 
    // output
    
    var umbrellaCheckData: BehaviorRelay<UmbrellaCheckDto> = BehaviorRelay<UmbrellaCheckDto>(value: UmbrellaCheckDto.umbrellaCheckDtoInitValue())
    var umbrellaLendData: BehaviorRelay<UmbrellaLendDto> = BehaviorRelay<UmbrellaLendDto>(value: UmbrellaLendDto())
    var lendErrorMessage: PublishSubject<String> = PublishSubject<String>()
    
    // input
    
    func umbrellaCheck(number: Int) {
        self.getUmbrellaCheckDto(number: number)
    }
    
    func umbrellaLend(number: Int) {
        if number == 0 {
            return
        }
        self.postUmbrellaLendDto(number: number)
    }
    
    init() {
    }
}

extension UmbrellaRentViewModel {
    
    func getUmbrellaCheckDto(number: Int) {
        UmbrellaAPI.shared.getUmbrellaCheck(number: number) { [weak self] response in
            guard (response?.status) != nil else { return }
            guard self != nil else { return }
            guard let data = response?.data else { return }
            self?.umbrellaCheckData.accept(data)
        }
    }
    
    func postUmbrellaLendDto(number: Int) {
        UmbrellaAPI.shared.postUmbrellaLend(number: number) { [weak self] response in
            guard (response?.status) != nil else { return }
            guard self != nil else { return }
            if response?.status == 200 {
                guard let data = response?.data else { return }
                self?.umbrellaLendData.accept(data)
                self?.lendErrorMessage.onNext("")
            } else {
                guard let message = response?.message else { return }
                self?.lendErrorMessage.onNext(message)
            }
        }
    }
}
