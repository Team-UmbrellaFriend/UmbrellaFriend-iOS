//
//  HomeAPI.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/25/24.
//

import Foundation

import Moya

final class HomeAPI {
    
    static let shared: HomeAPI = HomeAPI()
    
    private let homeProvider = MoyaProvider<HomeTarget>(plugins: [NetworkLoggerPlugin()])
    
    private init() {}
    
    public private(set) var homeData: GeneralResponse<HomeDto>?
    
    // MARK: - GET
    func getHome(completion: @escaping(GeneralResponse<HomeDto>?) -> Void) {
        
        homeProvider.request(.getHome) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.homeData = try response.map(GeneralResponse<HomeDto>.self)
                    guard let homeData = self.homeData else { return }
                    completion(homeData)
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
