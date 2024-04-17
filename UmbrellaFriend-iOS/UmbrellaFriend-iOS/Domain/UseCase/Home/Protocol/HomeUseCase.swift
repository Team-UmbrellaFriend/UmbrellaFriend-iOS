//
//  HomeUseCase.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/1/24.
//

import Foundation

import RxSwift
import RxCocoa

protocol HomeUseCase {
    
    var homeData: PublishRelay<HomeEntity> { get }
    
    func getHome()
}
