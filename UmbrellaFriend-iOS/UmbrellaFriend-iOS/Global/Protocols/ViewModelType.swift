//
//  ViewModelType.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/1/24.
//

import Foundation

import RxSwift

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    func transform(from input: Input, disposeBag: DisposeBag) -> Output
}
