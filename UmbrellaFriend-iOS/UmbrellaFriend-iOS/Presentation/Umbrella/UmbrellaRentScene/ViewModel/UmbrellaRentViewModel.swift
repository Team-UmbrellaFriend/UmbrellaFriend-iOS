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
}

protocol UmbrellaRentViewModelOutputs {
    
    var umbrellaCheckData: BehaviorRelay<UmbrellaCheckDto> { get }
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
    
    // input
    
    func umbrellaCheck(number: Int) {
        self.getUmbrellaCheckDto(number: number)
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
}
