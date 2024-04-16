//
//  AuthUseCase.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/16/24.
//

import Foundation

import RxSwift
import RxCocoa

protocol AuthUseCase {
    
    var logoutData: PublishRelay<BlankEntity> { get }
    
    func getLogout()
}
