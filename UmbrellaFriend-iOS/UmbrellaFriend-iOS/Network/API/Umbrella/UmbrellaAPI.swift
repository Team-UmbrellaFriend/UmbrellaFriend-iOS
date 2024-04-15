//
//  UmbrellaAPI.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/26/24.
//

import Foundation

import Moya

final class UmbrellaAPI {
    
    static let shared: UmbrellaAPI = UmbrellaAPI()
    
    private let umbrellaProvider = MoyaProvider<UmbrellaTarget>(plugins: [NetworkLoggerPlugin()])
    
    private init() {}
    
    public private(set) var umbrellaReturnData: GeneralResponse<UmbrellaReturnDto>?
    
    // MARK: - POST
    
    func postUmbrellaReturn(location: String,
                            image: Data,
                            completion: @escaping(GeneralResponse<UmbrellaReturnDto>?) -> Void) {
        umbrellaProvider.request(.postUmbrellaReturn(location: location, data: image)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.umbrellaReturnData = try response.map(GeneralResponse<UmbrellaReturnDto>.self)
                    guard let umbrellaReturnData = self.umbrellaReturnData else { return }
                    completion(umbrellaReturnData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
