//
//  MypageRepository.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/16/24.
//

import Moya
import RxSwift

protocol MypageRepository {
    
    var mypageResult: MypageEntity? { get set }
    
    func getMypage() -> Observable<MypageEntity>
}

final class DefaultMypageRepository {
    
    //MARK: - Dependency
    
    private let mypageService: MypageService
    static let shared = DefaultMypageRepository(mypageService: DefaultMypageService())
    
    //MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    var mypageResult: MypageEntity?
    
    //MARK: - Life Cycle
    
    init(mypageService: MypageService) {
        self.mypageService = mypageService
    }
}

extension DefaultMypageRepository: MypageRepository {
    
    func getMypage() -> Observable<MypageEntity> {
        mypageService.getMypage()
            .do(onSuccess: { [weak self] in self?.mypageResult = $0 } )
            .asObservable()
    }
}
