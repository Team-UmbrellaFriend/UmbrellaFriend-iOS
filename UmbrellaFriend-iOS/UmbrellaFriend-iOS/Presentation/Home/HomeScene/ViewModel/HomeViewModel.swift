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
    func reloadHomeView()
    func extendTapped()
}

protocol HomeViewModelOutputs {
    var homeData: BehaviorRelay<HomeDto> { get }
    var extendData: PublishSubject<UmbrellaExtendDto> { get }
    var extendErrorData: PublishSubject<String> { get }
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

final class HomeViewModel: HomeViewModelInputs, HomeViewModelOutputs, HomeViewModelType {
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }
 
    var homeData: BehaviorRelay<HomeDto> = BehaviorRelay<HomeDto>(value: HomeDto.homeDtoInitValue())
    var extendData: PublishSubject<UmbrellaExtendDto> = PublishSubject<UmbrellaExtendDto>()
    var extendErrorData: PublishSubject<String> = PublishSubject<String>()
    
    func reloadHomeView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.getHomeDto()
        }
    }
    
    func extendTapped() {
        self.getUmbrellaExtendDto()
    }
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.getHomeDto()
        }
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
    
    func getUmbrellaExtendDto() {
        UmbrellaAPI.shared.getUmbrellaExtend { [weak self] response in
            guard (response?.status) != nil else { return }
            guard self != nil else { return }
            if response?.status == 200 {
                guard let data = response?.data else { return }
                self?.extendData.onNext(data)
                self?.extendErrorData.onNext("")
            } else {
                guard let message = response?.message else { return }
                self?.extendErrorData.onNext(message)
            }
        }
    }
}
