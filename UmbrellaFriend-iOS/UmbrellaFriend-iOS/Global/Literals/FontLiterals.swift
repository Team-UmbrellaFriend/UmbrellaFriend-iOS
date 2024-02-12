//
//  FontLiterals.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/5/24.
//

import UIKit

struct FontName {
    static let SUITSemiBold = "SUIT-SemiBold"
}

extension UIFont {
    
    @nonobjc class func SUITSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: FontName.SUITSemiBold, size: size)!
    }
}
