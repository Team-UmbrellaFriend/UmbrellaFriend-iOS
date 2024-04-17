//
//  UmbrellaRepository.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/3/24.
//

import Moya
import RxSwift

protocol UmbrellaRepository {
    
    var umbrellaExtendResult: String? { get set }
    var umbrellaCheckResult: UmbrellaCheckEntity? { get set }
    
    func getUmbrellaExtend() -> Observable<String>
    func getUmbrellaAvailabe() -> Observable<[UmbrellaAvailableEntity]>
    func getUmbrellaCheck(umbrellaNum: Int) -> Observable<UmbrellaCheckEntity>
    func postUmbrellaLend(umbrellaNum: Int) -> Observable<String>
}

final class DefaultUmbrellaRepository {
    
    //MARK: - Dependency
    
    private let umbrellaService: UmbrellaService
    static let shared = DefaultUmbrellaRepository(umbrellaService: DefaultUmbrellaService())
    
    //MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    var umbrellaExtendResult: String?
    var umbrellaAvailableResult: [UmbrellaAvailableEntity]?
    var umbrellaCheckResult: UmbrellaCheckEntity?
    var umbrellaLendResult: String?
    
    //MARK: - Life Cycle
    
    init(umbrellaService: UmbrellaService) {
        self.umbrellaService = umbrellaService
    }
}

extension DefaultUmbrellaRepository: UmbrellaRepository {
    
    func getUmbrellaExtend() -> Observable<String> {
        umbrellaService.getUmbrellaExtend()
            .do(onSuccess: { [weak self] in self?.umbrellaExtendResult = $0 } )
            .asObservable()
    }
    
    func getUmbrellaAvailabe() -> Observable<[UmbrellaAvailableEntity]> {
        umbrellaService.getUmbrellaAvailable()
            .do(onSuccess: { [weak self] in self?.umbrellaAvailableResult = $0 } )
            .asObservable()
    }
    
    func getUmbrellaCheck(umbrellaNum: Int) -> Observable<UmbrellaCheckEntity> {
        umbrellaService.getUmbrellaCheck(umbrellaNum: umbrellaNum)
            .do(onSuccess: { [weak self] in self?.umbrellaCheckResult = $0 } )
            .asObservable()
    }
    
    func postUmbrellaLend(umbrellaNum: Int) -> Observable<String> {
        umbrellaService.postUmbrellaLend(umbrellaNum: umbrellaNum)
            .do(onSuccess: { [weak self] in self?.umbrellaLendResult = $0 })
            .asObservable()
    }
}
