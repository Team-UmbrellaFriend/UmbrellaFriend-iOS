//
//  LoginView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/17/24.
//

import UIKit

import SnapKit

final class LoginView: UIView {

    // MARK: - UI Components
    
    let navigationView: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.isBackButtonIncluded = true
        return nav
    }()
    
    private let loginTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요,\n로그인해주세요:)"
        label.textAlignment = .left
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.heading3)
        label.numberOfLines = 0
        return label
    }()
    
    private let idTextField = CustomTextField(placeHolder: "학번")
    private let pwTextField = CustomTextField(placeHolder: "비밀번호")
    lazy var loginButton = CustomButton(status: true, title: "로그인")
    
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

extension LoginView {

    func setUI() {
        backgroundColor = .umbrellaWhite
    }
    
    func setHierarchy() {
        addSubviews(navigationView, loginTitleLabel, idTextField, pwTextField, loginButton)
    }
    
    func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        loginTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(loginTitleLabel.snp.bottom).offset(68)
            $0.centerX.equalToSuperview()
        }
        
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(36)
            $0.centerX.equalToSuperview()
        }
    }
}
