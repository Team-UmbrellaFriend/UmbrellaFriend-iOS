//
//  UmbrellaReturnView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

import SnapKit

final class UmbrellaReturnView: UIView {
    
    // MARK: - UI Components
    
    let navigationView: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.isBackButtonIncluded = true
        return nav
    }()
    
    let returnTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "반납 완료를 위해\n카메라로 인증해주세요"
        label.textAlignment = .left
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.heading3)
        label.numberOfLines = 0
        return label
    }()
    
    let returnSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "네임택과 반납 장소가 보이게 찍어주세요"
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
        button.setImage(.icCancel, for: .normal)
        button.setImage(.icCancel, for: .highlighted)
        button.clipsToBounds = true
        return button
    }()
    
    let returnImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var returnButton = CustomButton(status: false, title: "반납하기")
    
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

private extension UmbrellaReturnView {

    func setUI() {
        backgroundColor = .umbrellaWhite
        returnImage.isHidden = true
        imageDeleteButton.isHidden = true
    }
    
    func setHierarchy() {
        addSubviews(navigationView, returnTitleLabel, returnSubTitleLabel, registerButton, returnButton, returnImage, imageDeleteButton)
    }
    
    func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        returnTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        
        returnSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(returnTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(returnTitleLabel.snp.leading)
        }
        
        registerButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(166)
        }
        
        returnButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
            $0.centerX.equalToSuperview()
        }
        
        returnImage.snp.makeConstraints {
            $0.top.equalTo(returnTitleLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 31)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 458 / 812)
        }
        
        imageDeleteButton.snp.makeConstraints {
            $0.top.trailing.equalTo(returnImage)
            $0.size.equalTo(48)
        }
    }
}
