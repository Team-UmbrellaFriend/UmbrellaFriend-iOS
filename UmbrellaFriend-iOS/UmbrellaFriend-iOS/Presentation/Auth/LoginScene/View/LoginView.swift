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
    
    let idTextField = CustomTextField(placeHolder: "학번")
    let pwTextField = CustomTextField(placeHolder: "비밀번호")
    lazy var loginButton = CustomButton(status: true, title: "로그인")
    let loginAlertView = CustomAlertView(subTitle: "")
    
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
        pwTextField.isSecureTextEntry = true
        loginAlertView.isHidden = true
    }
    
    func setHierarchy() {
        addSubviews(navigationView, loginTitleLabel, idTextField, pwTextField, loginButton, loginAlertView)
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
        
        loginAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension LoginView {
    
    func configureAlertView(message: String) {
        if message.contains("로그인되었습니다") {
            self.loginAlertView.alertTitleLabel.text = "성공!"
            self.loginAlertView.alertTitleLabel.textColor = .mainBlue
            self.loginAlertView.alertSubTitleLabel.text = message
        } else {
            self.loginAlertView.alertTitleLabel.text = "실패"
            self.loginAlertView.alertTitleLabel.textColor = .subOrange
            self.loginAlertView.alertSubTitleLabel.text = "다시 로그인해주세요"
        }
    }
}
