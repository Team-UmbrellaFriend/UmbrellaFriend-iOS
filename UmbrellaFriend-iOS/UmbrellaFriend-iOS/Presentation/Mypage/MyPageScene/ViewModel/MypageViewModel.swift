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
    func logout()
}

protocol MypageViewModelOutputs {
    var mypageData: BehaviorRelay<MypageDto> { get }
    var logoutData: PublishSubject<UserLogoutDto> { get }
    var reportMenuData: BehaviorRelay<[ReportMenuDto]>{ get }
}

protocol MypageViewModelType {
    
    var inputs: MypageViewModelInputs { get }
    var outputs: MypageViewModelOutputs { get }
}

final class MypageViewModel: MypageViewModelInputs, MypageViewModelOutputs, MypageViewModelType {
    
    var inputs: MypageViewModelInputs { return self }
    var outputs: MypageViewModelOutputs { return self }
 
    // output
    
    var mypageData: BehaviorRelay<MypageDto> = BehaviorRelay<MypageDto>(value: MypageDto.mypageDtoInitValue())
    var logoutData: PublishSubject<UserLogoutDto> = PublishSubject<UserLogoutDto>()
    var reportMenuData: BehaviorRelay<[ReportMenuDto]> = BehaviorRelay<[ReportMenuDto]>(value: ReportMenuDto.reportMenuDtoInitValue())
    
    // input
    
    func logout() {
        self.getLogout()
    }
    
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
    
    func getLogout() {
        AuthAPI.shared.getLogout{ [weak self] response in
            guard (response?.status) != nil else { return }
            if response?.status == 200 {
                guard self != nil else { return }
                guard let data = response?.data else { return }
                self?.logoutData.onNext(data)
            }
        }
    }
}
