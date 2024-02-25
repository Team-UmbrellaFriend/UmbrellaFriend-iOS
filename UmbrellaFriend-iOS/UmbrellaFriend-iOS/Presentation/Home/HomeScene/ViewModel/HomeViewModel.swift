//
//  HomeViewModel.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/25/24.
//

import UIKit

import RxSwift
import RxCocoa
import Moya

protocol HomeViewModelInputs {
    
}

protocol HomeViewModelOutputs {
    
    var homeData: BehaviorRelay<HomeDto> { get }
}

protocol HomeViewModelType {
    
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

final class HomeViewModel: HomeViewModelInputs, HomeViewModelOutputs, HomeViewModelType {
    
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }
 
    var homeData: BehaviorRelay<HomeDto> = BehaviorRelay<HomeDto>(value: HomeDto.homeDtoInitValue())
    
    init() {
        self.getHomeDto()
    }
}

extension HomeViewModel {
    
    func getHomeDto() {
        HomeAPI.shared.getHome { [weak self] response in
            guard (response?.status) != nil else { return }
            guard self != nil else { return }
            guard let data = response?.data else { return }
            self?.homeData.accept(data)
        }
    }
}
