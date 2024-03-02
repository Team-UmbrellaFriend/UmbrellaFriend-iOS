//
//  AuthAPI.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/2/24.
//

import Foundation

import Moya

final class AuthAPI {
    
    static let shared: AuthAPI = AuthAPI()
    
    private let authProvider = MoyaProvider<AuthTarget>(plugins: [NetworkLoggerPlugin()])
    
    private init() {}
    
    public private(set) var userProfileData: GeneralResponse<UserProfileDto>?
    
    // MARK: - GET
    func getMypage(id: Int,
                   completion: @escaping(GeneralResponse<UserProfileDto>?) -> Void) {
        authProvider.request(.getUserProfile(id: id)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.userProfileData = try response.map(GeneralResponse<UserProfileDto>.self)
                    guard let userProfileData = self.userProfileData else { return }
                    completion(userProfileData)
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
