//
//  WidgetFontLiterals.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 6/26/24.
//

import SwiftUI

enum FontName: String {
    case TmoneyRoundWindExtraBold = "TmoneyRoundWind-ExtraBold"
}

enum FontLevel {
    case widgetTitle
    case widgetNubmer
    case widgetPercent
    case widgetPlace
    case widgetRent
}

extension FontLevel {
    var fontWeight: String {
        return FontName.TmoneyRoundWindExtraBold.rawValue
    }
    
    var fontSize: CGFloat {
        switch self {
        case .widgetTitle:
            return 16
        case .widgetNubmer:
            return 40
        case .widgetPercent:
            return 24
        case .widgetPlace:
            return 13
        case .widgetRent:
            return 22
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .widgetTitle:
            return 22
        case .widgetNubmer, .widgetPercent:
            return 40
        case .widgetPlace:
            return 20
        case .widgetRent:
            return 30
        }
    }
    
    var letterSpacing: CGFloat {
        switch self {
        case .widgetRent:
            return 0
        default:
            return -0.5
        }
    }
}

extension Font {
    static func widgetUmbrellaFont(_ fontLevel: FontLevel) -> Font {
        return Font.custom(fontLevel.fontWeight, size: fontLevel.fontSize)
    }
}

struct UmbrellaTextModifier: ViewModifier {
    var fontLevel: FontLevel

    func body(content: Content) -> some View {
        content
            .font(.widgetUmbrellaFont(fontLevel))
            .lineSpacing(0)
            .padding(.vertical, (fontLevel.lineHeight - fontLevel.fontSize) / 2)
            .kerning(fontLevel.letterSpacing)
    }
}

extension View {
    func umbrellaWidgetFont(_ fontLevel: FontLevel) -> some View {
        self.modifier(UmbrellaTextModifier(fontLevel: fontLevel))
    }
}
