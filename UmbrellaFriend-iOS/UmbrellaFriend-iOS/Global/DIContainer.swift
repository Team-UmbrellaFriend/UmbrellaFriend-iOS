//
//  DIContainer.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/3/24.
//

import Foundation

final class DIContainer {
    
    static let shared = DIContainer()
    private init() {}
}

extension DIContainer {
    
    func makeHomeVC() -> HomeViewController {
        let homeService = DefaultHomeService()
        let homeRepo = DefaultHomeRepository(homeService: homeService)
        let homeUsecase = DefaultHomeUseCase(homeRepository: homeRepo)
        
        let vm = HomeViewModel(homeUseCase: homeUsecase)
        let vc = HomeViewController(viewModel: vm)
        return vc
    }
}
