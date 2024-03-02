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

protocol UmbrellaReturnViewModelInputs {
    
    func umbrellaReturnLocation(location: String)
    func umbrellaReturnImage(img: Data)
    func umbrellaReturn()
}

protocol UmbrellaReturnViewModelOutputs {
    
    var umbrellaReturnData: BehaviorRelay<UmbrellaReturnDto> { get }
}

protocol UmbrellaReturnViewModelType {
    
    var inputs: UmbrellaReturnViewModelInputs { get }
    var outputs: UmbrellaReturnViewModelOutputs { get }
}

final class UmbrellaReturnViewModel: UmbrellaReturnViewModelInputs, UmbrellaReturnViewModelOutputs, UmbrellaReturnViewModelType {
    
    var inputs: UmbrellaReturnViewModelInputs { return self }
    var outputs: UmbrellaReturnViewModelOutputs { return self }
    
    var image: Data?
    var location: String = ""
 
    // output
    
    var umbrellaReturnData: BehaviorRelay<UmbrellaReturnDto> = BehaviorRelay<UmbrellaReturnDto>(value: UmbrellaReturnDto())
    
    // input
    
    func umbrellaReturn() {
        self.postUmbrellaReturnDto(location: self.location, image: self.image ?? Data())
    }
    
    func umbrellaReturnLocation(location: String) {
        self.location = location
    }
    
    func umbrellaReturnImage(img: Data) {
        self.image = img
    }
}

extension UmbrellaReturnViewModel {
    
    func postUmbrellaReturnDto(location: String, image: Data) {
        UmbrellaAPI.shared.postUmbrellaReturn(location: location, image: image) { [weak self] response in
            guard (response?.status) != nil else { return }
            guard self != nil else { return }
            guard let data = response?.data else { return }
            self?.umbrellaReturnData.accept(data)
        }
    }
}
