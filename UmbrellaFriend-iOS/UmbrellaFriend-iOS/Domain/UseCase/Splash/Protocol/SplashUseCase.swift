//
//  SplashUseCase.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/29/24.
//

import Foundation

import RxSwift
import RxCocoa

protocol SplashUseCase {
    
    var versionData: PublishRelay<VersionInfoEntity> { get }
    
    func getVersion()
}
