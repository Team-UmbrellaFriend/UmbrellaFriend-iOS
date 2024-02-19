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
    
    let registerSubTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray700
        label.font = .umbrellaFont(.body3)
        return label
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setImage(.icRoundplus, for: .normal)
        button.setImage(.icRoundplus, for: .highlighted)
        button.setBackgroundColor(.gray200, for: .normal)
        button.setBackgroundColor(.gray300, for: .highlighted)
        button.clipsToBounds = true
        button.layer.cornerRadius = 80
        return button
    }()
    
    lazy var imageDeleteButton: UIButton = {
        let button = UIButton()
        button.setImage(.btnDelete, for: .normal)
        button.setBackgroundColor(.clear, for: .highlighted)
        button.clipsToBounds = true
        return button
    }()
    
    let studentIDImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
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

private extension PhotoAttachView {

    func setUI() {
        backgroundColor = .umbrellaWhite
        studentIDImage.isHidden = true
        imageDeleteButton.isHidden = true
    }
    
    func setHierarchy() {
        addSubviews(navigationView, registerTitleLabel, registerSubTitleLabel, registerButton, nextButton, studentIDImage, imageDeleteButton)
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
        
        registerSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(registerTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(registerTitleLabel.snp.leading)
        }
        
        registerButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(166)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
            $0.centerX.equalToSuperview()
        }
        
        studentIDImage.snp.makeConstraints {
            $0.top.equalTo(registerTitleLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(SizeLiterals.Screen.screenWidth - 31)
        }
        
        imageDeleteButton.snp.makeConstraints {
            $0.top.trailing.equalTo(studentIDImage).inset(12)
            $0.size.equalTo(20)
        }
    }
}
