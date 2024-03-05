//
//  SignupViewModel.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/2/24.
//

import UIKit

import RxSwift
import RxCocoa
import Moya

protocol SignupViewModelInputs {
    
    func userProfile(id: Int)
    func editProfile(id: Int, email: String, pw: String, phone: String)
}

protocol SignupViewModelOutputs {
    
    var userProfileData: BehaviorRelay<UserProfileDto> { get }
    var editProfileData: PublishSubject<UserProfileDto> { get }
}

protocol SignupViewModelType {
    
    var inputs: SignupViewModelInputs { get }
    var outputs: SignupViewModelOutputs { get }
}

final class SignupViewModel: SignupViewModelInputs, SignupViewModelOutputs, SignupViewModelType {
    
    var inputs: SignupViewModelInputs { return self }
    var outputs: SignupViewModelOutputs { return self }
 
    // output
    
    var userProfileData: BehaviorRelay<UserProfileDto> = BehaviorRelay<UserProfileDto>(value: UserProfileDto.userProfileDtoInitValue())
    var editProfileData: PublishSubject<UserProfileDto> = PublishSubject<UserProfileDto>()
    
    // input
    
    func userProfile(id: Int) {
        self.getUserProfileDto(id: id)
    }
    
    func editProfile(id: Int, email: String, pw: String, phone: String) {
        self.putUserProfileDto(id: id, email: email, pw: pw, phone: phone)
    }
    
    init() {

    }
}

extension SignupViewModel {
    
    func getUserProfileDto(id: Int) {
        AuthAPI.shared.getMypage(id: id) { [weak self] response in
            guard (response?.status) != nil else { return }
            guard self != nil else { return }
            guard let data = response?.data else { return }
            self?.userProfileData.accept(data)
        }
    }
    
    func putUserProfileDto(id: Int, email: String, pw: String, phone: String) {
        AuthAPI.shared.putUserProfile(id: id, email: email, pw: pw, phone: phone) { [weak self] response in
            guard (response?.status) != nil else { return }
            if response?.status == 200 {
                guard self != nil else { return }
                guard let data = response?.data else { return }
                self?.editProfileData.onNext(data)
            }
        }
    }
}
