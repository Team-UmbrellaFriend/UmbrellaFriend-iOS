//
//  UmbrellaReturnAlertView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

protocol CustomAlertButtonDelegate: AnyObject {
    func tapCheckButton()
}

final class CustomAlertView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: CustomAlertButtonDelegate?
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .umbrellaBlack.withAlphaComponent(0.6)
        return view
    }()
    
    let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .umbrellaWhite
        view.clipsToBounds = true
        view.layer.cornerRadius = 24
        return view
    }()
    
    private let alertTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .subOrange
        label.font = .umbrellaFont(.title1)
        return label
    }()
    
    private let alertSubTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .umbrellaBlack
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .umbrellaFont(.body3)
        return label
    }()
    
    lazy var alertCheckButton = CustomButton(status: true, title: "확인")
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, subTitle: String) {
        self.init()
        setUI(title: title, subTitle: subTitle)
        setHierarchy()
        setLayout()
    }
}

// MARK: - Extensions

private extension CustomAlertView {

    func setUI(title: String, subTitle: String) {
        backgroundColor = .clear
        self.alertTitleLabel.text = title
        self.alertSubTitleLabel.text = subTitle
        
        self.alertCheckButton.rx.tap
            .bind {
                self.delegate?.tapCheckButton()
            }
            .disposed(by: disposeBag)
    }
    
    func setHierarchy() {
        alertView.addSubviews(alertTitleLabel, alertSubTitleLabel, alertCheckButton)
        addSubviews(backgroundView, alertView)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 281 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 82)
            $0.height.equalTo(216)
        }
        
        alertTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(44)
            $0.centerX.equalToSuperview()
        }
        
        alertSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(alertTitleLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        alertCheckButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(14)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(107)
            $0.height.equalTo(44)
        }
    }
}
