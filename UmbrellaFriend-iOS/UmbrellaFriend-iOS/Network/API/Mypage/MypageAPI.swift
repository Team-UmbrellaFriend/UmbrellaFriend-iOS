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
    public private(set) var mypageReportData: GeneralResponse<MypageReportDto>?
    
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
    
    // MARK: - POST
    
    func postMypageReport(umbrellaNum: String,
                          reportReason: String,
                          description: String,
                          completion: @escaping(GeneralResponse<MypageReportDto>?) -> Void) {
        mypageProvider.request(.postMypageReport(umbrellaNum: umbrellaNum, reportReason: reportReason, description: description)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.mypageReportData = try response.map(GeneralResponse<MypageReportDto>.self)
                    guard let mypageReportData = self.mypageReportData else { return }
                    completion(mypageReportData)
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
