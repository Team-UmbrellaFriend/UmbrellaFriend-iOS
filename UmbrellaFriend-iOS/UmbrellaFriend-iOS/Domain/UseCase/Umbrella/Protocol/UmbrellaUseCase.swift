//
//  UmbrellaUseCase.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/11/24.
//

import Foundation

import RxSwift
import RxCocoa

protocol UmbrellaUseCase {
    
    var umbrellaExtendData: PublishRelay<String> { get }
    
    func getUmbrellaExtend()
}
