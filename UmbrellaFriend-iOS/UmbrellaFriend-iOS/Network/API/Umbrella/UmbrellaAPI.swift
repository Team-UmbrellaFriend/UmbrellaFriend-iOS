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
    
    public private(set) var umbrellaAvailableData: GeneralResponse<[UmbrellaAvailableDto]>?
    
    // MARK: - GET
    func getUmbrellaAvailable(completion: @escaping(GeneralResponse<[UmbrellaAvailableDto]>?) -> Void) {
        
        umbrellaProvider.request(.getUmbrellaAvailable) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.umbrellaAvailableData = try response.map(GeneralResponse<[UmbrellaAvailableDto]>.self)
                    guard let umbrellaAvailableData = self.umbrellaAvailableData else { return }
                    completion(umbrellaAvailableData)
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
