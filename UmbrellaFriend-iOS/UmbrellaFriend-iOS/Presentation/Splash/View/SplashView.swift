//
//  SplashView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/16/24.
//

import UIKit

import SnapKit

final class SplashView: UIView {
    
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
        image.image = UIImage(resource: .graphicCharacter)
        return image
    }()
    
    let forceUpdateAlert = CustomAlertView(type: .success,
                                                   title: "새로운 버전 업데이트!",
                                                   subTitle: "안정적인 서비스 사용을 위해\n최신 버전으로 업데이트해 주세요.")
    
    let recommendUpdateAlert = CustomAlertView(type: .success,
                                                   title: "새로운 버전 업데이트!",
                                                   subTitle: "안정적인 서비스 사용을 위해\n최신 버전으로 업데이트해 주세요.")
    
    let recommendCancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음에 할래요", for: .normal)
        button.setTitleColor(.umbrellaWhite, for: .normal)
        button.setBackgroundColor(.gray400, for: .normal)
        button.titleLabel?.font = .umbrellaFont(.body1)
        button.layer.cornerRadius = 12
        return button
    }()
    
    let recommendOkButton: UIButton = {
        let button = UIButton()
        button.setTitle("업데이트", for: .normal)
        button.setTitleColor(.umbrellaWhite, for: .normal)
        button.setBackgroundColor(.mainBlue, for: .normal)
        button.titleLabel?.font = .umbrellaFont(.body1)
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

private extension SplashView {

    func setUI() {
        backgroundColor = .white
        forceUpdateAlert.isHidden = true
        recommendUpdateAlert.isHidden = true
        recommendUpdateAlert.alertCheckButton.isHidden = true
    }
    
    func setHierarchy() {
        recommendUpdateAlert.alertView.addSubviews(recommendCancelButton, recommendOkButton)
        addSubviews(subTitleLabel, titleLabel, logoImage, forceUpdateAlert, recommendUpdateAlert)
    }
    
    func setLayout() {
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(SizeLiterals.Screen.screenHeight * 192 / 812)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        logoImage.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-252)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(275)
            $0.height.equalTo(196)
        }
        
        forceUpdateAlert.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        recommendUpdateAlert.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        recommendCancelButton.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(16)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 104) / 2)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 44 / 812)
        }
        
        recommendOkButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(16)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 104) / 2)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 44 / 812)
        }
    }
}

extension SplashView {
    
    func bindUpdateAlert(myVersion: String, version: VersionDto) -> Bool {
        if myVersion == "1.0.0" {
            return false
        }
        if myVersion <= version.forceVeresion {
            forceUpdateAlert.isHidden = false
            recommendUpdateAlert.isHidden = true
            return true
        } else if myVersion <= version.recommendVersion {
            forceUpdateAlert.isHidden = true
            recommendUpdateAlert.isHidden = false
            return true
        } else {
            forceUpdateAlert.isHidden = true
            recommendUpdateAlert.isHidden = true
            return false
        }
    }
}
