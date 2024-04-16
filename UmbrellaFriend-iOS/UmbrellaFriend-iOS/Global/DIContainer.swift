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
    
    func makeUmbrellaRentVC() -> UmbrellaRentViewController {
        let umbrellaService = DefaultUmbrellaService()
        let umbrellaRepo = DefaultUmbrellaRepository(umbrellaService: umbrellaService)
        let umbrellaUsecase = DefaultUmbrellaUseCase(umbrellaRepository: umbrellaRepo)
        let vm = UmbrellaRentViewModel(umbrellaUseCase: umbrellaUsecase)
        let vc = UmbrellaRentViewController(viewModel: vm)
        return vc
    }
    
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
    
    func makeMypageVC() -> MypageViewController {
        let mypageService = DefaultMypageService()
        let mypageRepo = DefaultMypageRepository(mypageService: mypageService)
        let mypageUseCase = DefaultMypageUseCase(mypageRepository: mypageRepo)
        let vm = MypageViewModel(mypageUseCase: mypageUseCase)
        let vc = MypageViewController(viewModel: vm)
        return vc
    }
}
