//
//  UILabel+.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/12/24.
//

import UIKit

extension UILabel {
    
    func setLineSpacing(lineSpacing: CGFloat) {
        if let text = self.text {
            let attributedStr = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpacing
            attributedStr.addAttribute(NSAttributedString.Key.paragraphStyle,
                                       value: style,
                                       range: NSMakeRange(0, attributedStr.length))
            self.attributedText = attributedStr
        }
    }
    
    func setUnderline(targetString: String) {
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        self.attributedText = attributedString
    }
}
