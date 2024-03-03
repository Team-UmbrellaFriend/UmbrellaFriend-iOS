//
//  LoginViewModel.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/4/24.
//

import UIKit

import RxSwift
import RxCocoa
import Moya

protocol LoginViewModelInputs {
    
    func login(id: String, pw: String)
}

protocol LoginViewModelOutputs {
    
    var userLoginData: PublishSubject<UserLoginDto> { get }
}

protocol LoginViewModelType {
    
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

final class LoginViewModel: LoginViewModelInputs, LoginViewModelOutputs, LoginViewModelType {
    
    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }
 
    // output
    
    var userLoginData: PublishSubject<UserLoginDto> = PublishSubject<UserLoginDto>()
    
    // input
    
    func login(id: String, pw: String) {
        self.postLogin(id: id, pw: pw)
    }
    
    init() {

    }
}

extension LoginViewModel {
    
    func postLogin(id: String, pw: String) {
        AuthAPI.shared.postLogin(id: id, pw: pw) { [weak self] response in
            guard (response?.status) != nil else { return }
            if response?.status == 200 {
                guard self != nil else { return }
                guard let data = response?.data else { return }
                self?.userLoginData.onNext(data)
            }
        }
    }
}
