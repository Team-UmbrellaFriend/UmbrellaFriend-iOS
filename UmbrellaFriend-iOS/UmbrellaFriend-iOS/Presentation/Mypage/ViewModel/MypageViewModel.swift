//
//  MypageViewModel.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/2/24.
//

import UIKit

import RxSwift
import RxCocoa
import Moya

protocol MypageViewModelInputs {
    
}

protocol MypageViewModelOutputs {
    
    var mypageData: BehaviorRelay<MypageDto> { get }
}

protocol MypageViewModelType {
    
    var inputs: MypageViewModelInputs { get }
    var outputs: MypageViewModelOutputs { get }
}

final class MypageViewModel: MypageViewModelInputs, MypageViewModelOutputs, MypageViewModelType {
    
    var inputs: MypageViewModelInputs { return self }
    var outputs: MypageViewModelOutputs { return self }
 
    var mypageData: BehaviorRelay<MypageDto> = BehaviorRelay<MypageDto>(value: MypageDto.mypageDtoInitValue())
    
    init() {
        self.getMypageDto()
    }
}

extension MypageViewModel {
    
    func getMypageDto() {
        MypageAPI.shared.getMypage { [weak self] response in
            guard (response?.status) != nil else { return }
            guard self != nil else { return }
            guard let data = response?.data else { return }
            self?.mypageData.accept(data)
        }
    }
}
