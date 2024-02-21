//
//  HomeView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/21/24.
//

import UIKit

import SnapKit

final class HomeView: UIView {
    
    // MARK: - UI Components
    
    let userView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray200
        view.clipsToBounds = true
        view.layer.cornerRadius = 36
        return view
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "눈송이님"
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.title1)
        return label
    }()
    
    lazy var goMyPageButton: UIButton = {
        let button = UIButton()
        button.setImage(.icRight, for: .normal)
        button.setImage(.icRight, for: .highlighted)
        return button
    }()
    
    private let userInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘은 비가 올 확률이 적네요!"
        label.textColor = .umbrellaBlack
        label.textAlignment = .center
        label.font = .umbrellaFont(.body3)
        label.clipsToBounds = true
        label.backgroundColor = .umbrellaWhite
        label.layer.cornerRadius = 29
        return label
    }()
    
    let todayInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlue
        view.clipsToBounds = true
        view.layer.cornerRadius = 36
        return view
    }()
    
    private let todayDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2024년 2월 6일"
        label.textColor = .umbrellaWhite
        label.font = .umbrellaFont(.title1)
        return label
    }()
    
    private let todayRainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘 비 올 확률"
        label.textColor = .umbrellaWhite
        label.font = .umbrellaFont(.body2)
        return label
    }()
    
    private let todayRainPercentLabel: UILabel = {
        let label = UILabel()
        label.text = "20%"
        label.textColor = .umbrellaWhite
        label.font = .umbrellaFont(.heading1)
        return label
    }()
    
    let rentView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 36
        return view
    }()
    
    private let rentTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "우산 대여"
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.body1)
        return label
    }()
    
    private let rentSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "우산을 대여할 수 있어요"
        label.textColor = .gray700
        label.font = .umbrellaFont(.caption1)
        return label
    }()
    
    let returnView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray200
        view.clipsToBounds = true
        view.layer.cornerRadius = 36
        return view
    }()
    
    private let returnTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "우산 반납"
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.body1)
        return label
    }()
    
    private let returnSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "사용한 우산을 반납해요"
        label.textColor = .gray700
        label.font = .umbrellaFont(.caption1)
        return label
    }()
    
    let mapView: UIView = {
        let view = UIView()
        view.backgroundColor = .subOrange
        view.clipsToBounds = true
        view.layer.cornerRadius = 36
        return view
    }()
    
    private let mapTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "우산 대여 지도"
        label.textColor = .umbrellaWhite
        label.font = .umbrellaFont(.body1)
        return label
    }()
    
    private let mapSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "대여할 수 있는 우산의 위치를 파악해요"
        label.textColor = .lightOrange
        label.font = .umbrellaFont(.caption1)
        return label
    }()
    
    private let userProfileIcon = CustomIcon(type: .homeProfile)
    private let rentIcon = CustomIcon(type: .homeRent)
    let returnIcon = CustomIcon(type: .homeReturn)
    private let mapIcon = CustomIcon(type: .homeMap)
    private let rentBackIcon = UIImageView(image: UIImage(resource: .icFullUnfoldUmbrella).withTintColor(.umbrellaWhite))
    private let returnBackIcon = UIImageView(image: UIImage(resource: .icFoldUmbrellaBig))
    private let mapBackIcon = UIImageView(image: UIImage(resource: .icUmbrellaMap))
    
    // MARK: - Life Cycles
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rentView.applyGradient()
    }
    
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

private extension HomeView {

    func setUI() {
        backgroundColor = .umbrellaWhite
    }
    
    func setHierarchy() {
        userView.addSubviews(userProfileIcon, userNameLabel, goMyPageButton, userInfoLabel)
        todayInfoView.addSubviews(todayDateLabel, todayRainTitleLabel, todayRainPercentLabel)
        rentView.addSubviews(rentIcon, rentBackIcon, rentTitleLabel, rentSubTitleLabel)
        returnView.addSubviews(returnIcon, returnBackIcon, returnTitleLabel, returnSubTitleLabel)
        mapView.addSubviews(mapIcon, mapBackIcon, mapTitleLabel, mapSubTitleLabel)
        addSubviews(userView, todayInfoView, rentView, returnView, mapView)
    }
    
    func setLayout() {
        userView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(SizeLiterals.Screen.screenHeight * 4 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 32)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 153 / 812)
        }
        
        userProfileIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(userProfileIcon).offset(15)
            $0.leading.equalTo(userProfileIcon.snp.trailing).offset(12)
        }
        
        goMyPageButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        userInfoLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 48)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 56 / 812)
        }
        
        todayInfoView.snp.makeConstraints {
            $0.top.equalTo(userView.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 8 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 32)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 203 / 812)
        }
        
        todayDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 34 / 812)
            $0.centerX.equalToSuperview()
        }
        
        todayRainTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(todayRainPercentLabel.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        todayRainPercentLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 34 / 812)
            $0.centerX.equalToSuperview()
        }
        
        rentView.snp.makeConstraints {
            $0.top.equalTo(todayInfoView.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 8 / 812)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 41) / 2)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 166 / 812)
        }
        
        rentIcon.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        
        rentBackIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(53)
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(192)
        }
        
        rentSubTitleLabel.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(16)
        }
        
        rentTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(rentSubTitleLabel.snp.top).offset(-2)
            $0.leading.equalTo(rentSubTitleLabel.snp.leading)
        }
        
        returnView.snp.makeConstraints {
            $0.top.equalTo(todayInfoView.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 8 / 812)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 41) / 2)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 166 / 812)
        }
        
        returnIcon.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        
        returnBackIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(48)
            $0.leading.equalToSuperview().inset(5)
            $0.size.equalTo(192)
        }
        
        returnSubTitleLabel.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(16)
        }
        
        returnTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(returnSubTitleLabel.snp.top).offset(-2)
            $0.leading.equalTo(returnSubTitleLabel.snp.leading)
        }
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(rentView.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 8 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 32)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 168 / 812)
        }
        
        mapIcon.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        
        mapBackIcon.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(-9)
            $0.size.equalTo(192)
        }
        
        mapSubTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(17)
        }
        
        mapTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(mapSubTitleLabel.snp.top).offset(-2)
            $0.leading.equalTo(mapSubTitleLabel.snp.leading)
        }
    }
}
