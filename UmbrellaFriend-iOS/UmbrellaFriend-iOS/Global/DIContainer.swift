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
    
    func makeUmbrellaMapVC() -> UmbrellaMapViewController {
        let umbrellaService = DefaultUmbrellaService()
        let umbrellaRepo = DefaultUmbrellaRepository(umbrellaService: umbrellaService)
        let umbrellaUsecase = DefaultUmbrellaUseCase(umbrellaRepository: umbrellaRepo)
        let vm = UmbrellaMapViewModel(umbrellaUseCase: umbrellaUsecase)
        let vc = UmbrellaMapViewController(viewModel: vm)
        return vc
    }
    
    func makeHomeVC() -> HomeViewController {
        let homeService = DefaultHomeService()
        let umbrellaService = DefaultUmbrellaService()
        let homeRepo = DefaultHomeRepository(homeService: homeService)
        let umbrellaRepo = DefaultUmbrellaRepository(umbrellaService: umbrellaService)
        let homeUsecase = DefaultHomeUseCase(homeRepository: homeRepo)
        let umbrellaUsecase = DefaultUmbrellaUseCase(umbrellaRepository: umbrellaRepo)
        
        let vm = HomeViewModel(homeUseCase: homeUsecase, umbrellaUseCase: umbrellaUsecase)
        let vc = HomeViewController(viewModel: vm)
        return vc
    }
}
