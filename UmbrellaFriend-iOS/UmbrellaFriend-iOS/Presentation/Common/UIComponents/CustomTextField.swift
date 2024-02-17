//
//  CustomTextField.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/17/24.
//

import UIKit

import SnapKit

final class CustomTextField: UITextField {

    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeHolder: String) {
        self.init()
        
        setUI(placeHolder: placeHolder)
    }
}

// MARK: - Extensions

private extension CustomTextField {
    
    func setUI(placeHolder: String) {
        self.placeholder = "\(placeHolder)"
        self.textColor = .gray1100
        self.backgroundColor = .gray100
        self.font = .umbrellaFont(.body2)
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [
            .foregroundColor: UIColor.gray500,
            .font: UIFont.umbrellaFont(.body3)
        ])
        self.layer.cornerRadius =  12
        self.setLeftPadding(amount: 12)
    }
    
    func setLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 32)
            $0.height.equalTo(54)
        }
    }
}
