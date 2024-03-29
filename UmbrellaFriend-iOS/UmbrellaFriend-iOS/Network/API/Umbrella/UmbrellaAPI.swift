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
    public private(set) var umbrellaCheckData: GeneralResponse<UmbrellaCheckDto>?
    public private(set) var umbrellaLendData: GeneralResponse<UmbrellaLendDto>?
    public private(set) var umbrellaReturnData: GeneralResponse<UmbrellaReturnDto>?
    public private(set) var umbrellaExtendData: GeneralResponse<UmbrellaExtendDto>?
    
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
    
    func getUmbrellaCheck(number: Int,
                          completion: @escaping(GeneralResponse<UmbrellaCheckDto>?) -> Void) {
        umbrellaProvider.request(.getUmbrellaCheck(umbrellaNumber: number)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.umbrellaCheckData = try response.map(GeneralResponse<UmbrellaCheckDto>.self)
                    guard let umbrellaCheckData = self.umbrellaCheckData else { return }
                    completion(umbrellaCheckData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getUmbrellaExtend(completion: @escaping(GeneralResponse<UmbrellaExtendDto>?) -> Void) {
        umbrellaProvider.request(.getUmbrellaExtend) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.umbrellaExtendData = try response.map(GeneralResponse<UmbrellaExtendDto>.self)
                    guard let umbrellaExtendData = self.umbrellaExtendData else { return }
                    completion(umbrellaExtendData)
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
    
    func postUmbrellaLend(number: Int,
                          completion: @escaping(GeneralResponse<UmbrellaLendDto>?) -> Void) {
        umbrellaProvider.request(.postUmbrellaLend(umbrellaNumber: number)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.umbrellaLendData = try response.map(GeneralResponse<UmbrellaLendDto>.self)
                    guard let umbrellaLendData = self.umbrellaLendData else { return }
                    completion(umbrellaLendData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
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
