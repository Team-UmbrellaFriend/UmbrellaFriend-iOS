//
//  NSObject+.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/5/24.
//

import Foundation

extension NSObject {
    
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
}
