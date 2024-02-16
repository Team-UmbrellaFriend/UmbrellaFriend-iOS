//
//  FontLiterals.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/5/24.
//

import UIKit

enum FontName: String {
    case SUITBold = "SUIT-Bold"
    case SUITMedium = "SUIT-Medium"
    case SUITRegular = "SUIT-Regular"
    case SUITSemiBold = "SUIT-SemiBold"
    case TmoneyRoundWindExtraBold = "TmoneyRoundWindExtraBold"
}

enum FontLevel {
    case logo
    
    case heading1
    case heading2
    case heading3
    
    case title1
    case subtitle1
    
    case body1
    case body2
    case body3
    case body4
    case body5
    
    case caption1
}

extension FontLevel {
    
    var fontWeight: String {
        switch self {
        case .logo:
            return FontName.TmoneyRoundWindExtraBold.rawValue
        case .heading1, .heading2, .heading3, .title1, .subtitle1, .body1:
            return FontName.SUITBold.rawValue
        case .body2, .body4:
            return FontName.SUITSemiBold.rawValue
        case .body3, .body5:
            return FontName.SUITMedium.rawValue
        case .caption1:
            return FontName.SUITRegular.rawValue
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .logo, .heading2:
            return 28
        case .heading1:
            return 48
        case .heading3:
            return 24
        case .title1:
            return 20
        case .subtitle1:
            return 18
        case .body1, .body2, .body3:
            return 16
        case .body4, .body5:
            return 14
        case .caption1:
            return 12
        }
    }
}

extension UIFont {
    static func umbrellaFont(_ fontLevel: FontLevel) -> UIFont {
        let font = UIFont(name: fontLevel.fontWeight, size: fontLevel.fontSize)!
        return font
    }
}
