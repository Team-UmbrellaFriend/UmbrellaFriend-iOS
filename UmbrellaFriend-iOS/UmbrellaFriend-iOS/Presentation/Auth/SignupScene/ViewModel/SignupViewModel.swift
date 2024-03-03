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
}

protocol SignupViewModelOutputs {
    
    var userProfileData: BehaviorRelay<UserProfileDto> { get }
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
    
    // input
    
    func userProfile(id: Int) {
        self.getUserProfileDto(id: id)
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
}
