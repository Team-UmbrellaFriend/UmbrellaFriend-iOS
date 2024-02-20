//
//  CustomTextField.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/17/24.
//

import UIKit

import SnapKit

final class CustomTextField: UITextField {
    
    // MARK: - Properties
    
    @frozen
    enum TexFieldType {
        case normal
        case editing
        case uncorrectedType
        
        var borderColor: CGColor? {
            switch self {
            case .normal, .editing:
                return UIColor.clear.cgColor
            case .uncorrectedType:
                return UIColor.umbrellaError.cgColor
            }
        }
        
        var borderWidth: CGFloat {
            switch self {
            case .normal, .editing:
                return 0
            case .uncorrectedType:
                return 1
            }
        }
        
        var textColor: UIColor? {
            switch self {
            case .normal, .editing:
                return UIColor.umbrellaBlack
            case .uncorrectedType:
                return UIColor.umbrellaError
            }
        }
    }
    
    var textFieldStatus: TexFieldType = .normal {
        didSet {
            updateBorderColor()
        }
    }

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
    
    func updateBorderColor() {
        self.layer.borderColor = textFieldStatus.borderColor
        self.layer.borderWidth = textFieldStatus.borderWidth
        self.textColor = textFieldStatus.textColor
    }
}
