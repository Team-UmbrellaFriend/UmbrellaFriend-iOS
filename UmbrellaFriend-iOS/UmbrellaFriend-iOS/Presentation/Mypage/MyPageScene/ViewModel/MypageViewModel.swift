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
    func report(num: Int, reason: String, description: String)
}

protocol MypageViewModelOutputs {
    var mypageData: BehaviorRelay<MypageDto> { get }
    var logoutData: PublishSubject<UserLogoutDto> { get }
    var reportMenuData: BehaviorRelay<[ReportMenuDto]>{ get }
    var mypageReportMessage: PublishSubject<String> { get }
    var mypageReportCode: PublishSubject<Int> { get }
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
    var mypageReportMessage: PublishSubject<String> = PublishSubject<String>()
    var mypageReportCode: PublishSubject<Int> =  PublishSubject<Int>()
    
    // input
    
    func logout() {
        self.getLogout()
    }
    
    func report(num: Int, reason: String, description: String) {
        self.postMypageReport(umbrellaNum: num, reportReason: reason, description: description)
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
    
    func postMypageReport(umbrellaNum: Int, reportReason: String, description: String) {
        MypageAPI.shared.postMypageReport(umbrellaNum: umbrellaNum, reportReason: reportReason, description: description){ [weak self] response in
            guard (response?.status) != nil else { return }
            guard self != nil else { return }
            guard let message = response?.message else { return }
            self?.mypageReportMessage.onNext(message)
            if response?.status == 201 {
                guard let code = response?.status else { return }
                self?.mypageReportCode.onNext(code)
            }
        }
    }
}
