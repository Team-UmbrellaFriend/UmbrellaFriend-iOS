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

protocol UmbrellaMapViewModelInputs {
    
    func mapIconTapped(with index: Int)
}

protocol UmbrellaMapViewModelOutputs {
    
    var umbrellaAvailableData: BehaviorRelay<UmbrellaAvailableDto> { get }
}

protocol UmbrellaMapViewModelType {
    
    var inputs: UmbrellaMapViewModelInputs { get }
    var outputs: UmbrellaMapViewModelOutputs { get }
}

final class UmbrellaMapViewModel: UmbrellaMapViewModelInputs, UmbrellaMapViewModelOutputs, UmbrellaMapViewModelType {
    
    var inputs: UmbrellaMapViewModelInputs { return self }
    var outputs: UmbrellaMapViewModelOutputs { return self }
 
    var responseData : [UmbrellaAvailableDto] = []
    var umbrellaAvailableData: BehaviorRelay<UmbrellaAvailableDto> = BehaviorRelay<UmbrellaAvailableDto>(value: UmbrellaAvailableDto.umbrellaAvailableDtoInitValue())
    
    init() {
        self.getUmbrellaAvailable()
    }
    
    func mapIconTapped(with index: Int) {
        self.umbrellaAvailableData.accept(responseData[index - 1])
    }
}

extension UmbrellaMapViewModel {
    
    func getUmbrellaAvailable() {
        UmbrellaAPI.shared.getUmbrellaAvailable { [weak self] response in
            guard (response?.status) != nil else { return }
            guard self != nil else { return }
            guard let data = response?.data else { return }
            self?.responseData = data
            self?.umbrellaAvailableData.accept(data[0])
        }
    }
}
