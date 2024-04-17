//
//  HomeService.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/25/24.
//

import Foundation

import Moya
import RxSwift
import RxMoya

protocol HomeService {
    
    func getHome() -> Single<HomeEntity>
}

final class DefaultHomeService: NSObject {
    
    private var homeProvider = MoyaProvider<HomeTarget>(plugins: [NetworkLoggerPlugin()])
}

extension DefaultHomeService: HomeService {
    
    func getHome() -> Single<HomeEntity> {
        homeProvider.rx.request(.getHome)
            .filterSuccessfulStatusCodes()
            .mapGenericResponse(HomeEntity.self)
    }
}
