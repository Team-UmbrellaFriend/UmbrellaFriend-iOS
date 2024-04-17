//
//  MypageUseCase.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/16/24.
//

import Foundation

import RxSwift
import RxCocoa

protocol MypageUseCase {
    
    var mypageData: PublishRelay<MypageEntity> { get }
    var mypageReportData: PublishRelay<String> { get }
    
    func getMypage()
    func postMypageReport(requestDto: MypageReportRequestDto)
}
