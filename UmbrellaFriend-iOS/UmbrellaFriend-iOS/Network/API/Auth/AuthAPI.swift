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
    
    public private(set) var userLoginData: GeneralResponse<UserLoginDto>?
    public private(set) var userProfileData: GeneralResponse<UserProfileDto>?
    public private(set) var editProfileData: GeneralResponse<UserProfileDto>?
    public private(set) var userLogoutData: GeneralResponse<UserLogoutDto>?
    public private(set) var userSingupData: GeneralResponse<UserLoginDto>?
    
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
    
    func getLogout(completion: @escaping(GeneralResponse<UserLogoutDto>?) -> Void) {
        authProvider.request(.getLogout) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.userLogoutData = try response.map(GeneralResponse<UserLogoutDto>.self)
                    guard let userLogoutData = self.userLogoutData else { return }
                    completion(userLogoutData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    // MARK: - POST
    func postLogin(id: String,
                   pw: String,
                   completion: @escaping(GeneralResponse<UserLoginDto>?) -> Void) {
        authProvider.request(.postLogin(id: id, pw: pw)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.userLoginData = try response.map(GeneralResponse<UserLoginDto>.self)
                    guard let userLoginData = self.userLoginData else { return }
                    completion(userLoginData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func postSignup(username: String, email: String, pw: String, studentId: Int, img: Data, phone: String,
                   completion: @escaping(GeneralResponse<UserLoginDto>?) -> Void) {
        authProvider.request(.postSignup(username: username, email: email, pw: pw, studentId: studentId, img: img, phone: phone)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.userSingupData = try response.map(GeneralResponse<UserLoginDto>.self)
                    guard let userSingupData = self.userSingupData else { return }
                    completion(userSingupData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    // MARK: - PUT
    func putUserProfile(id: Int, email: String, pw: String, phone: String,
                        completion: @escaping(GeneralResponse<UserProfileDto>?) -> Void) {
        authProvider.request(.putUserProfile(id: id, email: email, pw: pw, phone: phone)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.editProfileData = try response.map(GeneralResponse<UserProfileDto>.self)
                    guard let editProfileData = self.editProfileData else { return }
                    completion(editProfileData)
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
