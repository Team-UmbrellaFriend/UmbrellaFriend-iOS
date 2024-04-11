//
//  Single+.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/1/24.
//

import Foundation

import RxSwift
import Moya

extension PrimitiveSequenceType where Trait == SingleTrait {
    
    public func umbrellaFriendSubscribe<Object: AnyObject>(
        with object: Object,
        onSuccess: ((Object, Element) -> Void)? = nil,
        onFailure: ((Object, NetworkServiceError?) -> Void)? = nil,
        onDisposed: ((Object) -> Void)? = nil
    ) -> Disposable {
        subscribe(
            onSuccess: { [weak object] in
                guard let object else { return }
                onSuccess?(object, $0)
            },
            onFailure: { [weak object] in
                guard let object else { return }
                guard let error = $0 as? MoyaError else { return }
                switch error {
                case .underlying(_, let response):
                    guard let statusCode = response?.statusCode else { return }
                    guard let networkError = NetworkServiceError(rawValue: statusCode) else { return }
                    onFailure?(object, networkError)
                default:
                    onFailure?(object, nil)
                }
                
            },
            onDisposed: { [weak object] in
                guard let object else { return }
                onDisposed?(object)
            }
        )
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Moya.Response {

    func mapGenericResponse<Response: Decodable>(_ type: Response.Type) -> Single<Response> {
        return map(GeneralResponse<Response>.self)
            .map { $0.data }
            .do(onSuccess: { guard $0 != nil else { throw NetworkServiceError.emptyDataError }})
            .map { $0! }
    }
}
