//
//  HomeRepository.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/1/24.
//

import Moya
import RxSwift

protocol HomeRepository {
    
    var homeResult: HomeEntity? { get set }
    
    func getHome() -> Observable<HomeEntity>
}

final class DefaultHomeRepository {
    
    //MARK: - Dependency
    
    private let homeService: HomeService
    static let shared = DefaultHomeRepository(homeService: DefaultHomeService())
    
    //MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    var homeResult: HomeEntity?
    
    //MARK: - Life Cycle
    
    private init(homeService: HomeService) {
        self.homeService = homeService
    }
}

//MARK: - Home Repository

extension DefaultHomeRepository: HomeRepository {
    
    func getHome() -> Observable<HomeEntity> {
        homeService.getHome()
            .do(onSuccess: { [weak self] in self?.homeResult = $0 } )
            .asObservable()
    }
}
