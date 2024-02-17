//
//  CustomButton.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/17/24.
//

import UIKit

import SnapKit

protocol ButtonProtocol: AnyObject {
    
    func buttonTapped()
}

final class CustomButton: UIButton {
    
    // MARK: - Properties
    
    weak var delegate: ButtonProtocol?
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(status: Bool, title: String) {
        self.init()
        
        setUI(status: status, title: title)
    }
}

// MARK: - Extensions

private extension CustomButton {
    
    func setUI(status: Bool, title: String) {
        self.isEnabled = status
        self.setTitle(title, for: .normal)
        self.setTitleColor(.umbrellaWhite, for: .normal)
        self.setTitleColor(.umbrellaWhite, for: .disabled)
        self.setBackgroundColor(.mainBlue, for: .normal)
        self.setBackgroundColor(.gray300, for: .disabled)
        self.titleLabel?.font = .umbrellaFont(.subtitle1)
        self.clipsToBounds = true
        self.layer.cornerRadius = 12
    }
    
    func setLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 32)
            $0.height.equalTo(54)
        }
    }
    
    func setAddTarget() {
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped() {
        delegate?.buttonTapped()
    }
}
