//
//  SignupView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/18/24.
//

import UIKit

import SnapKit

final class SignupView: UIView {

    // MARK: - UI Components
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .umbrellaWhite
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let navigationView: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.isBackButtonIncluded = true
        return nav
    }()
    
    let signupTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "기본 정보를\n입력해주세요."
        label.textAlignment = .left
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.heading3)
        label.numberOfLines = 0
        return label
    }()
    
    private let nameTitle: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = .umbrellaFont(.body5)
        label.textColor = .gray1000
        return label
    }()
    
    private let idTitle: UILabel = {
        let label = UILabel()
        label.text = "학번"
        label.font = .umbrellaFont(.body5)
        label.textColor = .gray1000
        return label
    }()
    
    private let phoneTitle: UILabel = {
        let label = UILabel()
        label.text = "전화번호"
        label.font = .umbrellaFont(.body5)
        label.textColor = .gray1000
        return label
    }()
    
    private let emailTitle: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.font = .umbrellaFont(.body5)
        label.textColor = .gray1000
        return label
    }()
    
    private let emailFormLabel: UILabel = {
        let label = UILabel()
        label.text = "@sookmyung.ac.kr"
        label.textAlignment = .center
        label.textColor = .gray1100
        label.font = .umbrellaFont(.body3)
        label.backgroundColor = .gray100
        label.clipsToBounds = true
        label.layer.cornerRadius = 12
        return label
    }()
    
    private let pwTitle: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = .umbrellaFont(.body5)
        label.textColor = .gray1000
        return label
    }()
    
    private let pwInfoTitle: UILabel = {
        let label = UILabel()
        label.text = "*영어, 숫자로 이루어진 최소 8자 이상 (특수문자x)"
        label.textColor = .gray600
        label.font = .umbrellaFont(.caption1)
        label.textColor = .gray1000
        return label
    }()
    
    let nameTextField = CustomTextField(placeHolder: "눈송이")
    let idTextField = CustomTextField(placeHolder: "111111")
    let phoneTextField = CustomTextField(placeHolder: "01012341234")
    let emailTextField = CustomTextField(placeHolder: "woosanfriend")
    let pwTextField = CustomTextField(placeHolder: "비밀번호")
    let pwCheckTextField = CustomTextField(placeHolder: "비밀번호확인")
    lazy var completeButton = CustomButton(status: false, title: "완료")
    
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

private extension SignupView {

    func setUI() {
        backgroundColor = .umbrellaWhite
        pwTextField.isSecureTextEntry = true
        pwCheckTextField.isSecureTextEntry = true
    }
    
    func setHierarchy() {
        addSubviews(navigationView, signupTitleLabel, scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(nameTitle, nameTextField, idTitle, idTextField, phoneTitle, phoneTextField, emailTitle, emailTextField, emailFormLabel, pwTitle, pwTextField, pwCheckTextField, pwInfoTitle,  completeButton)
    }
    
    func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        signupTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(signupTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.greaterThanOrEqualTo(self.snp.height).priority(.low)
            $0.width.equalTo(scrollView.snp.width)
        }
        
        nameTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(signupTitleLabel.snp.leading)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameTitle.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        idTitle.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.leading.equalTo(signupTitleLabel.snp.leading)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(idTitle.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        phoneTitle.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(20)
            $0.leading.equalTo(signupTitleLabel.snp.leading)
        }
        
        phoneTextField.snp.makeConstraints {
            $0.top.equalTo(phoneTitle.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        emailTitle.snp.makeConstraints {
            $0.top.equalTo(phoneTextField.snp.bottom).offset(20)
            $0.leading.equalTo(signupTitleLabel.snp.leading)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailTitle.snp.bottom).offset(10)
            $0.leading.equalTo(emailTitle.snp.leading)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 40) / 2 + 3)
        }
        
        emailFormLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.top)
            $0.leading.equalTo(emailTextField.snp.trailing).offset(8)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 40) / 2 - 3)
            $0.height.equalTo(54)
        }
        
        pwTitle.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.equalTo(signupTitleLabel.snp.leading)
        }
        
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(pwTitle.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        pwCheckTextField.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        pwInfoTitle.snp.makeConstraints {
            $0.top.equalTo(pwCheckTextField.snp.bottom).offset(8)
            $0.leading.equalTo(pwCheckTextField.snp.leading).offset(8)
        }
        
        completeButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
            $0.centerX.equalToSuperview()
        }
    }
}

extension SignupView {
    
    func configureView(model: UserProfileDto) {
        nameTextField.text = model.username
        let email = model.email
        if let emailID = email.firstIndex(of: "@") {
            let username = String(email.prefix(upTo: emailID))
            emailTextField.text = username
        }
        idTextField.text = "\(model.profile.studentID)"
        phoneTextField.text = model.profile.phoneNumber
    }
}
