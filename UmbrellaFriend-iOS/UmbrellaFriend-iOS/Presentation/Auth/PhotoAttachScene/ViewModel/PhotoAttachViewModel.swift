//
//  PhotoAttachViewModel.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/5/24.
//

import UIKit

import RxSwift
import RxCocoa
import Moya

protocol PhotoAttachViewModelInputs {
    
    func signup(username: String, email: String, pw: String, studentId: Int, phone: String)
    func signupImage(image: Data)
}

protocol PhotoAttachViewModelOutputs {
    
    var signupData: PublishSubject<UserLoginDto> { get }
    var signupErrorMessage: PublishSubject<String> { get }
}

protocol PhotoAttachViewModelType {
    
    var inputs: PhotoAttachViewModelInputs { get }
    var outputs: PhotoAttachViewModelOutputs { get }
}

final class PhotoAttachViewModel: PhotoAttachViewModelInputs, PhotoAttachViewModelOutputs, PhotoAttachViewModelType {
    
    var inputs: PhotoAttachViewModelInputs { return self }
    var outputs: PhotoAttachViewModelOutputs { return self }
    
    var image: Data?
 
    // output
    
    var signupData: PublishSubject<UserLoginDto> = PublishSubject<UserLoginDto>()
    var signupErrorMessage: PublishSubject<String> = PublishSubject<String>()
    
    // input

    func signup(username: String, email: String, pw: String, studentId: Int, phone: String) {
        self.postSignup(username: username, email: email, pw: pw, studentId: studentId, phone: phone)
    }
    
    func signupImage(image: Data) {
        self.image = image
    }
    
    init() {

    }
}

extension PhotoAttachViewModel {
    
    func postSignup(username: String, email: String, pw: String, studentId: Int, phone: String) {
        AuthAPI.shared.postSignup(username: username, email: email, pw: pw, studentId: studentId, img: self.image ?? Data(), phone: phone) { [weak self] response in
            guard (response?.status) != nil else { return }
            if response?.status == 201 {
                guard self != nil else { return }
                guard let data = response?.data else { return }
                self?.signupData.onNext(data)
                self?.signupErrorMessage.onNext("")
            } else {
                guard let message = response?.message else { return }
                self?.signupErrorMessage.onNext(message)
            }
        }
    }
}
