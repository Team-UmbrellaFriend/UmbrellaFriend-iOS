//
//  UmbrellaReturnBottomSheetView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

import SnapKit

final class UmbrellaReturnBottomSheetView: UIView {

    // MARK: - Properties
    
    
    // MARK: - UI Components
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .umbrellaBlack.withAlphaComponent(0.6)
        return view
    }()
    
    let bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .umbrellaWhite
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 24
        view.clipsToBounds = false
        return view
    }()
    
    private let returnTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "반납 완료할 장소를 선택해주세요"
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.title1)
        return label
    }()
    
    lazy var returnPlaceCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.itemSize = CGSize(width: 160, height: 166)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var returnCancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.umbrellaWhite, for: .normal)
        button.setBackgroundColor(.gray400, for: .normal)
        button.setBackgroundColor(.gray500, for: .highlighted)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .umbrellaFont(.subtitle1)
        return button
    }()
    
    lazy var returnProgressButton: UIButton = {
        let button = UIButton()
        button.setTitle("반납 완료", for: .normal)
        button.setTitleColor(.umbrellaWhite, for: .normal)
        button.setBackgroundColor(.mainBlue, for: .normal)
        button.setBackgroundColor(.darkBlue, for: .highlighted)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .umbrellaFont(.subtitle1)
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

private extension UmbrellaReturnBottomSheetView {

    func setUI() {
        backgroundColor = .clear
    }
    
    func setHierarchy() {
        bottomSheetView.addSubviews(returnTitleLabel, returnPlaceCollectionView, returnCancelButton, returnProgressButton)
        addSubviews(backgroundView, bottomSheetView)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheetView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        returnTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(41)
            $0.centerX.equalToSuperview()
        }
        
        returnPlaceCollectionView.snp.makeConstraints {
            $0.top.equalTo(returnTitleLabel.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(166)
        }
        
        returnCancelButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(57)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 40) / 2)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 54 / 812)
        }
        
        returnProgressButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(57)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 40) / 2)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 54 / 812)
        }
    }
    
    func setRegisterCell() {
        UmbrellaReturnPlaceCollectionViewCell.register(target: returnPlaceCollectionView)
    }
}
