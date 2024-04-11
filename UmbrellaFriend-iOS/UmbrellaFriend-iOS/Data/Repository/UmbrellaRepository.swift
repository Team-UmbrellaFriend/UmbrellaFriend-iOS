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
    
    func getUmbrellaExtend() -> Observable<String>
}

final class DefaultUmbrellaRepository {
    
    //MARK: - Dependency
    
    private let umbrellaService: UmbrellaService
    static let shared = DefaultUmbrellaRepository(umbrellaService: DefaultUmbrellaService())
    
    //MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    var umbrellaExtendResult: String?
    
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
}
