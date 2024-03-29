//
//  ReportNumberView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/25/24.
//

import UIKit

import SnapKit

final class ReportNumberView: UIView {

    // MARK: - UI Components
    
    let navigationView: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.isBackButtonIncluded = true
        return nav
    }()
    
    let reportTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "신고할 우산번호를\n입력해주세요"
        label.textAlignment = .left
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.heading3)
        label.numberOfLines = 0
        return label
    }()
    
    let numberTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "우산번호"
        label.textColor = .gray1000
        label.font = .umbrellaFont(.body5)
        return label
    }()
    
    let numberTextField = CustomTextField(placeHolder: "1234")
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

private extension ReportNumberView {

    func setUI() {
        backgroundColor = .umbrellaWhite
    }
    
    func setHierarchy() {
        addSubviews(navigationView, reportTitleLabel, numberTitleLabel, numberTextField, nextButton)
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
        
        numberTitleLabel.snp.makeConstraints {
            $0.top.equalTo(reportTitleLabel.snp.bottom).offset(40)
            $0.leading.equalTo(reportTitleLabel.snp.leading)
        }
        
        numberTextField.snp.makeConstraints {
            $0.top.equalTo(numberTitleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
            $0.centerX.equalToSuperview()
        }
    }
}
