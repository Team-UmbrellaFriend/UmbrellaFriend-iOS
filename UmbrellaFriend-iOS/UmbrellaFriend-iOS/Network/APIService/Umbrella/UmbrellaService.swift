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
}
