//
//  PhotoAttachView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/17/24.
//

import UIKit

import SnapKit

final class PhotoAttachView: UIView {
    
    // MARK: - UI Components
    
    let navigationView: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.isBackButtonIncluded = true
        return nav
    }()
    
    let registerTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.heading3)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setImage(.btnRegister, for: .normal)
        button.setBackgroundColor(.clear, for: .highlighted)
        button.clipsToBounds = true
        return button
    }()
    
    lazy var nextButton = CustomButton(status: false, title: "다음")
    
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

extension PhotoAttachView {

    func setUI() {
        backgroundColor = .umbrellaWhite
    }
    
    func setHierarchy() {
        addSubviews(navigationView, registerTitleLabel, registerButton, nextButton)
    }
    
    func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        registerTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        
        registerButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(166)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
            $0.centerX.equalToSuperview()
        }
    }
}
