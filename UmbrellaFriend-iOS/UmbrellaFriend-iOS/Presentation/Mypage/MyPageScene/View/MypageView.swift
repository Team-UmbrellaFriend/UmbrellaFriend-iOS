//
//  MypageView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/2/24.
//

import UIKit

import SnapKit

final class MypageView: UIView {

    // MARK: - UI Components
    
    let navigationView: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.isBackButtonIncluded = true
        nav.isLogoutButtonInclued = true
        return nav
    }()
    
    private let userProfileIcon = CustomIcon(type: .mypageProfile)
    
    private let userProfileView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightBlue
        view.clipsToBounds = true
        view.layer.cornerRadius = 36
        return view
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.title1)
        return label
    }()
    
    private let userIDLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray900
        label.font = .umbrellaFont(.body3)
        return label
    }()
    
    private let userPhoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray900
        label.font = .umbrellaFont(.body3)
        return label
    }()
    
    private let userEmailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray900
        label.font = .umbrellaFont(.body3)
        return label
    }()
    
    lazy var profileEditButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 수정", for: .normal)
        button.setTitleColor(.umbrellaWhite, for: .normal)
        button.setBackgroundColor(.mainBlue, for: .normal)
        button.setBackgroundColor(.darkBlue, for: .highlighted)
        button.titleLabel?.font = .umbrellaFont(.body2)
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        return button
    }()
    
    private let historyView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray200
        view.clipsToBounds = true
        view.layer.cornerRadius = 48 / 2
        return view
    }()
    
    private let historyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "대여 내역"
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.subtitle1)
        return label
    }()
    
    lazy var historyCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.itemSize = CGSize(width: SizeLiterals.Screen.screenWidth - 80, height: 35)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.clipsToBounds = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let emptyImage = UIImageView(image: UIImage(resource: .graphicNoHistory))
    
    private let emptyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 내역이 없어요"
        label.textColor = .gray500
        label.font = .umbrellaFont(.body4)
        return label
    }()
    
    let reportButton: UIButton = {
        let button = UIButton()
        button.setTitle("신고하기", for: .normal)
        button.titleLabel?.font = .umbrellaFont(.body2)
        button.setTitleColor(.gray500, for: .normal)
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setRegisterCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension MypageView {

    func setUI() {
        backgroundColor = .umbrellaWhite
    }
    
    func setHierarchy() {
        userProfileView.addSubviews(userNameLabel, userIDLabel, userPhoneLabel, userEmailLabel, profileEditButton)
        historyView.addSubviews(historyTitleLabel, historyCollectionView)
        addSubviews(navigationView, userProfileView, userProfileIcon, historyView, emptyImage, emptyTitleLabel, reportButton)
    }
    
    func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        userProfileView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 32)
            $0.height.equalTo(229)
        }
        
        userProfileIcon.snp.makeConstraints {
            $0.top.equalTo(userProfileView.snp.top).inset(-32)
            $0.centerX.equalToSuperview()
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(userProfileIcon.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        userIDLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
        }
        
        userPhoneLabel.snp.makeConstraints {
            $0.top.equalTo(userIDLabel.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        
        userEmailLabel.snp.makeConstraints {
            $0.top.equalTo(userPhoneLabel.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        
        profileEditButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 56)
            $0.height.equalTo(48)
        }
        
        historyView.snp.makeConstraints {
            $0.top.equalTo(userProfileView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 32)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 354 / 812)
        }
        
        historyTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        
        historyCollectionView.snp.makeConstraints {
            $0.top.equalTo(historyTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 354 / 812 - 84)
        }
        
        emptyImage.snp.makeConstraints {
            $0.top.equalTo(historyTitleLabel.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 54 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(129)
        }
        
        emptyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(emptyImage.snp.bottom).offset(11)
            $0.centerX.equalToSuperview()
        }
        
        reportButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-32)
            $0.leading.equalToSuperview().inset(36)
        }
    }
    
    func setRegisterCell() {
        MypageCollectionViewCell.register(target: historyCollectionView)
    }
}

extension MypageView {

    func configureView(model: MypageDto) {
        userNameLabel.text = model.user.username
        userIDLabel.text = "\(model.user.studentID)"
        userPhoneLabel.text = model.user.phoneNumber
        userEmailLabel.text = model.user.email
        
        if model.history.count > 0 {
            emptyImage.isHidden = true
            emptyTitleLabel.isHidden = true
        } else {
            emptyImage.isHidden = false
            emptyTitleLabel.isHidden = false
        }
    }
}
