//
//  ReportView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/21/24.
//

import UIKit

import SnapKit

final class ReportView: UIView {

    // MARK: - UI Components
    
    let navigationView: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.isBackButtonIncluded = true
        return nav
    }()
    
    let reportTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "신고하기"
        label.textAlignment = .left
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.heading3)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var reportCollectionView: UICollectionView = {
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
    
    let reportTextView: UITextView = {
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
    
    lazy var reportButton = CustomButton(status: false, title: "신고하기")
    
    let reportAlertView = CustomAlertView(subTitle: "")
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setRegisterCell()
        setDelegate()
        setGesture()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension ReportView {

    func setUI() {
        backgroundColor = .umbrellaWhite
        reportAlertView.alertTitleLabel.text = "접수되었어요!"
        reportAlertView.isHidden = true
    }
    
    func setHierarchy() {
        addSubviews(navigationView, reportTitleLabel, reportCollectionView, reportTextView, reportButton, reportAlertView)
    }
    
    func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        reportTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(13)
            $0.leading.equalToSuperview().inset(16)
        }
        
        reportCollectionView.snp.makeConstraints {
            $0.top.equalTo(reportTitleLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 32)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 186 / 812)
        }
        
        reportTextView.snp.makeConstraints {
            $0.top.equalTo(reportCollectionView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 32)
            $0.height.equalTo(152)
        }
        
        reportButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
            $0.centerX.equalToSuperview()
        }
        
        reportAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setRegisterCell() {
        ReportCollectionViewCell.register(target: reportCollectionView)
    }
    
    func setDelegate() {
        reportTextView.delegate = self
    }
    
    func setGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown(_:)))
        swipeGesture.direction = .down
        self.addGestureRecognizer(swipeGesture)
    }
    
    @objc func handleSwipeDown(_ sender: UISwipeGestureRecognizer) {
        self.endEditing(true)
    }
    
    func checkMaxLength(_ textView: UITextView) {
        
        if textView.numberOfLines() <= 5 {
            textView.isEditable = true
        } else {
            textView.deleteBackward()
        }
    }
}

extension ReportView: UITextViewDelegate {
    
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
            reportButton.isEnabled = false
        } else {
            reportButton.isEnabled = true
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

extension ReportView {
    
    func configureReportAlert(message: String) {
        reportAlertView.alertSubTitleLabel.text = message
    }
}
