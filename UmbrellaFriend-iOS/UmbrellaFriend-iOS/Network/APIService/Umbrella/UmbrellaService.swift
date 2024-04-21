//
//  UmbrellaService.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/11/24.
//

import Foundation

import Moya
import RxSwift
import RxMoya

protocol UmbrellaService {
    
    func getUmbrellaExtend() -> Single<String>
    func getUmbrellaAvailable() -> Single<[UmbrellaAvailableEntity]>
    func getUmbrellaCheck(umbrellaNum: Int) -> Single<UmbrellaCheckEntity>
    func postUmbrellaLend(umbrellaNum: Int) -> Single<String>
    func postUmbrellaReturn(requestDto: UmbrellaReturnRequestDto) -> Single<Int>
}

final class DefaultUmbrellaService: NSObject {
    
    private var umbrellaProvider = MoyaProvider<UmbrellaTarget>(plugins: [NetworkLoggerPlugin()])
}

extension DefaultUmbrellaService: UmbrellaService {
    
    func getUmbrellaExtend() -> Single<String> {
        umbrellaProvider.rx.request(.getUmbrellaExtend)
            .map { response in
                let genericResponse = try response.map(GeneralResponse<UmbrellaExtendEntity>.self)
                return genericResponse.message
            }
    }
    
    func getUmbrellaAvailable() -> Single<[UmbrellaAvailableEntity]> {
        umbrellaProvider.rx.request(.getUmbrellaAvailable)
            .filterSuccessfulStatusCodes()
            .mapGenericResponse([UmbrellaAvailableEntity].self)
    }
    
    func getUmbrellaCheck(umbrellaNum: Int) -> Single<UmbrellaCheckEntity> {
        umbrellaProvider.rx.request(.getUmbrellaCheck(umbrellaNumber: umbrellaNum))
            .filterSuccessfulStatusCodes()
            .mapGenericResponse(UmbrellaCheckEntity.self)
    }
    
    func postUmbrellaLend(umbrellaNum: Int) -> Single<String> {
        umbrellaProvider.rx.request(.postUmbrellaLend(umbrellaNumber: umbrellaNum))
            .map { response in
                let genericResponse = try response.map(GeneralResponse<UmbrellaLendEntity>.self)
                return genericResponse.message
            }
    }
    
    func postUmbrellaReturn(requestDto: UmbrellaReturnRequestDto) -> Single<Int> {
        umbrellaProvider.rx.request(.postUmbrellaReturn(returnData: requestDto))
            .map { response in
                let genericResponse = try response.map(GeneralResponse<BlankEntity>.self)
                return genericResponse.status
            }
    }
}
