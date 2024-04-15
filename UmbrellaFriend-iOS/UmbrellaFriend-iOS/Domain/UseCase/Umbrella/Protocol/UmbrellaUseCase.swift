//
//  UmbrellaUseCase.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/11/24.
//

import Foundation

import RxSwift
import RxCocoa

protocol UmbrellaUseCase {
    
    var umbrellaExtendData: PublishRelay<String> { get }
    var umbrellaAvailableData: PublishRelay<[UmbrellaAvailableEntity]> { get }
    var umbrellaCheckData: PublishRelay<UmbrellaCheckEntity> { get }
    var umbrellaLendData: PublishRelay<String> { get }
    
    func getUmbrellaExtend()
    func getUmbrellaAvailable()
    func getUmbrellaCheck(umbrellaNum: Int)
    func postUmbrellaLend(umbrellaNum: Int)
}
