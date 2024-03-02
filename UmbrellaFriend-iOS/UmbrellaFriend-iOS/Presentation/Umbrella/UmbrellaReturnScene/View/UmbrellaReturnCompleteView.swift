//
//  UmbrellaReturnCompleteView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

import SnapKit

final class UmbrellaReturnCompleteView: UIView {
    
    // MARK: - UI Components
    
    private let returnCompleteLabel: UILabel = {
        let label = UILabel()
        label.text = "우산 반납이 완료되었습니다.\n다음에 또 이용해주세요:)"
        label.textColor = .umbrellaBlack
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .umbrellaFont(.title1)
        return label
    }()
    
    private let returnCompleteImage = UIImageView(image: UIImage(resource: .graphicComplete))
    lazy var goHomeButton = CustomButton(status: true, title: "홈으로")
    
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

private extension UmbrellaReturnCompleteView {

    func setUI() {
        backgroundColor = .umbrellaWhite
    }
    
    func setHierarchy() {
        addSubviews(returnCompleteLabel, returnCompleteImage, goHomeButton)
    }
    
    func setLayout() {
        returnCompleteLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(92)
            $0.centerX.equalToSuperview()
        }
        
        returnCompleteImage.snp.makeConstraints {
            $0.top.equalTo(returnCompleteLabel.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 131 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(283)
            $0.height.equalTo(207)
        }
        
        goHomeButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
            $0.centerX.equalToSuperview()
        }
    }
}
