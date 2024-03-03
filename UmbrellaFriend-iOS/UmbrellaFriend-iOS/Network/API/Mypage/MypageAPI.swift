//
//  MypageAPI.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/2/24.
//

import Foundation

import Moya

final class MypageAPI {
    
    static let shared: MypageAPI = MypageAPI()
    
    private let mypageProvider = MoyaProvider<MypageTarget>(plugins: [NetworkLoggerPlugin()])
    
    private init() {}
    
    public private(set) var mypageData: GeneralResponse<MypageDto>?
    
    // MARK: - GET
    func getMypage(completion: @escaping(GeneralResponse<MypageDto>?) -> Void) {
        mypageProvider.request(.getMypage) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.mypageData = try response.map(GeneralResponse<MypageDto>.self)
                    guard let mypageData = self.mypageData else { return }
                    completion(mypageData)
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
