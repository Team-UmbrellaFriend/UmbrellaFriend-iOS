//
//  WithdrawView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/24/24.
//

import UIKit

import SnapKit

final class WithdrawView: UIView {

    // MARK: - Properties
    
    var withdrawCheckSelected: Bool {
        didSet {
            
        }
    }
    
    // MARK: - UI Components
    
    let navigationView: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.isBackButtonIncluded = true
        return nav
    }()
    
    let withdrawTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "탈퇴하기"
        label.textAlignment = .left
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.heading3)
        return label
    }()
    
    let withdrawSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "계정을 삭제하면, 프로필, 우산 대여 및 반납 등 모든 활동 정보가 삭제됩니다. 계정 삭제 후 일간 다시 가입할 수 없어요."
        label.textAlignment = .left
        label.textColor = .gray700
        label.font = .umbrellaFont(.body3)
        label.numberOfLines = 0
        return label
    }()
    
    private let withdrawCheckView: UIView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray300
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    private let withdrawCheckImage = UIImageView(image: .icCheck)
    
    private let withdrawCheckTitle: UILabel = {
        let label = UILabel()
        label.text = "유의사항을 확인했어요."
        label.textAlignment = .left
        label.textColor = .gray700
        label.font = .umbrellaFont(.body3)
        return label
    }()
    
    private let withdrawReasonTitle: UILabel = {
        let label = UILabel()
        label.text = "탈퇴 사유를 알려주세요."
        label.textAlignment = .left
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.subtitle1)
        return label
    }()
    
    lazy var withdrawReasonCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = SizeLiterals.Screen.screenHeight * 12 / 812
        flowLayout.itemSize = CGSize(width: SizeLiterals.Screen.screenWidth - 32, height: SizeLiterals.Screen.screenHeight * 54 / 812)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.clipsToBounds = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isUserInteractionEnabled = true
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let withdrawReasonTextView: UITextView = {
        let textView = UITextView()
        textView.text = "기타사항 (직접 입력)"
        textView.font = .umbrellaFont(.body2)
        textView.textColor = .gray500
        textView.textContainer.maximumNumberOfLines = 5
        textView.showsHorizontalScrollIndicator = false
        textView.backgroundColor = .gray100
        textView.layer.cornerRadius = 12
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 18, left: 12, bottom: 0, right: 12)
        return textView
    }()
    
    lazy var withdrawButton = CustomButton(status: false, title: "탈퇴하기")
    let withdrawAlertView = CustomAlertView(type: .fail, title: "잠시만요!", subTitle: "")
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setRegisterCell()
        setDelegate()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension WithdrawView {

    func setUI() {
        backgroundColor = .umbrellaWhite
        withdrawAlertView.isHidden = true
    }
    
    func setHierarchy() {
        addSubviews(navigationView, withdrawTitleLabel, withdrawSubTitleLabel, withdrawCheckView, withdrawCheckImage, withdrawReasonTitle, withdrawReasonCollectionView, withdrawReasonTextView, withdrawButton, withdrawAlertView)
    }
    
    func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        withdrawTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(13)
            $0.leading.equalToSuperview().inset(16)
        }
        
        withdrawSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(withdrawTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        withdrawCheckView.snp.makeConstraints {
            $0.top.equalTo(withdrawSubTitleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
        
        withdrawCheckImage.snp.makeConstraints {
            $0.top.leading.equalTo(withdrawCheckView)
            $0.size.equalTo(24)
        }
        
        withdrawCheckTitle.snp.makeConstraints {
            $0.top.equalTo(withdrawCheckView.snp.top)
            $0.leading.equalTo(withdrawCheckView.snp.trailing).offset(8)
        }
        
        withdrawReasonTitle.snp.makeConstraints {
            $0.top.equalTo(withdrawCheckView.snp.bottom).offset(32)
            $0.leading.equalTo(withdrawCheckView.snp.leading)
        }
        
        withdrawReasonCollectionView.snp.makeConstraints {
            $0.top.equalTo(withdrawReasonTitle.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 32)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 186 / 812)
        }
        
        withdrawReasonTextView.snp.makeConstraints {
            $0.top.equalTo(withdrawReasonCollectionView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 32)
            $0.height.equalTo(152)
        }
        
        withdrawButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
            $0.centerX.equalToSuperview()
        }
        
        withdrawAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setRegisterCell() {
        ReportCollectionViewCell.register(target: withdrawReasonCollectionView)
    }
    
    func setDelegate() {
        withdrawReasonTextView.delegate = self
    }
    
    func checkMaxLength(_ textView: UITextView) {
        
        if textView.numberOfLines() <= 5 {
            textView.isEditable = true
        } else {
            textView.deleteBackward()
        }
    }
}

extension WithdrawView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray500 {
            textView.text = nil
            textView.textColor = .umbrellaBlack
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "기타사항 (직접 입력)"
            textView.textColor = .gray500
            withdrawButton.isEnabled = false
        } else {
            withdrawButton.isEnabled = true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: self.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if estimatedSize.height >= 152 {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
        checkMaxLength(textView)
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
}


extension WithdrawView {
    
    func configureWithdrawAlert(message: String) -> Bool {
        withdrawAlertView.changedSubtitle = message
        if !message.contains("성공") {
            withdrawAlertView.alertIcon.image = .icAlertNotice
            withdrawAlertView.alertTitleLabel.text = "잠시만요!"
            return false
        } else {
            withdrawAlertView.alertIcon.image = .icAlertCheck
            withdrawAlertView.alertTitleLabel.text = "탈퇴 완료"
            return true
        }
    }
}
