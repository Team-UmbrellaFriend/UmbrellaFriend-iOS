//
//  UmbrellaReturnBottomSheetView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

import SnapKit

final class UmbrellaReturnBottomSheetView: UIView {

    // MARK: - UI Components
    
    let umbrellaReturnCompleteView = UmbrellaReturnCompleteView()
    
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
    
    lazy var returnProgressButton = CustomButton(status: false, title: "반납완료")
    let umbrellaReturnAlertView = CustomAlertView(title: "잠깐만요!", subTitle: "선택한 장소와 일치하지 않아요.\n다시 인증해주세요.")
    
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
        umbrellaReturnCompleteView.isHidden = true
        umbrellaReturnAlertView.isHidden = true
    }
    
    func setHierarchy() {
        bottomSheetView.addSubviews(returnTitleLabel, returnPlaceCollectionView, returnProgressButton)
        addSubviews(backgroundView, bottomSheetView, umbrellaReturnAlertView, umbrellaReturnCompleteView)
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
        
        returnProgressButton.snp.makeConstraints {
            $0.top.equalTo(returnPlaceCollectionView.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 24 / 812)
            $0.centerX.equalToSuperview()
        }
        
        umbrellaReturnCompleteView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        umbrellaReturnAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setRegisterCell() {
        UmbrellaReturnPlaceCollectionViewCell.register(target: returnPlaceCollectionView)
    }
}
