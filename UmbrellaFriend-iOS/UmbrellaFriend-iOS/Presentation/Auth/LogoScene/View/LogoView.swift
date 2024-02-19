//
//  LogoView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/16/24.
//

import UIKit

import SnapKit

final class LogoView: UIView {

    // MARK: - Properties
    
    
    // MARK: - UI Components
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "비 올 때마다 생각나는 친구"
        label.font = .umbrellaFont(.body3)
        label.textColor  = .gray1000
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "우산친구"
        label.font = .umbrellaFont(.logo)
        label.textColor  = .umbrellaBlack
        return label
    }()
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .logo)
        return image
    }()
    
    lazy var loginButton = CustomButton(status: true, title: "로그인")
    
    lazy var signupButton: UIButton = {
        var button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.mainBlue, for: .normal)
        button.titleLabel?.font = .umbrellaFont(.subtitle1)
        button.setBackgroundColor(.lightBlue, for: .normal)
        button.setBackgroundColor(.middleBlue, for: .highlighted)
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension LogoView {

    func setUI() {
        backgroundColor = .white
    }
    
    func setHierarchy() {
        addSubviews(subTitleLabel, titleLabel, logoImage, loginButton, signupButton)
    }
    
    func setLayout() {
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(SizeLiterals.Screen.screenHeight * 136 / 812)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        logoImage.snp.makeConstraints {
            $0.bottom.equalTo(loginButton.snp.top).offset(-SizeLiterals.Screen.screenHeight * 160 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(275)
            $0.height.equalTo(196)
        }
        
        signupButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-41)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 32)
            $0.height.equalTo(54)
        }
        
        loginButton.snp.makeConstraints {
            $0.bottom.equalTo(signupButton.snp.top).offset(-8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 32)
            $0.height.equalTo(54)
        }
    }
}
