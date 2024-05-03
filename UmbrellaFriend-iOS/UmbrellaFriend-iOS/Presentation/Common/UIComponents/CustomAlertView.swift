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

enum AlertType {
    case success
    case fail
    case notice
    
    var iconImage: UIImage {
        switch self {
        case .success:
            return .icAlertCheck
        case .fail:
            return .icAlertFail
        case .notice:
            return .icAlertNotice
        }
    }
}

protocol CustomAlertButtonDelegate: AnyObject {
    func tapCheckButton()
}

final class CustomAlertView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: CustomAlertButtonDelegate?
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let backgroundView: UIView = {
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
    
    let alertIcon = UIImageView()
    
    let alertTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.title1)
        return label
    }()
    
    let alertSubTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray900
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .umbrellaFont(.body3)
        return label
    }()
    
    lazy var alertCheckButton = CustomButton(status: true, title: "확인")
    
    var changedSubtitle: String = "" {
        didSet {
            alertSubTitleLabel.text = changedSubtitle
            self.alertView.snp.updateConstraints {
                $0.height.equalTo(SizeLiterals.Screen.deviceRatio > 0.5 ? 208 : (changedSubtitle.contains("\n") ? SizeLiterals.Screen.screenHeight * 226 / 812 : SizeLiterals.Screen.screenHeight * 204 / 812))
            }
            setNeedsLayout()
        }
    }
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(type: AlertType, title: String, subTitle: String) {
        self.init()
        
        setUI(type: type, title: title, subTitle: subTitle)
        setHierarchy()
        setLayout(lineNum: subTitle.contains("\n") ? 2 : 1)
    }
}

// MARK: - Extensions

private extension CustomAlertView {

    func setUI(type: AlertType, title: String, subTitle: String) {
        backgroundColor = .clear
        self.alertIcon.image = type.iconImage
        self.alertTitleLabel.text = title
        self.alertSubTitleLabel.text = subTitle
        
        self.alertCheckButton.rx.tap
            .bind {
                self.delegate?.tapCheckButton()
            }
            .disposed(by: disposeBag)
    }
    
    func setHierarchy() {
        alertView.addSubviews(alertIcon, alertTitleLabel, alertSubTitleLabel, alertCheckButton)
        addSubviews(backgroundView, alertView)
    }
    
    func setLayout(lineNum: Int) {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 277 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 64)
            $0.height.equalTo(SizeLiterals.Screen.deviceRatio > 0.5 ? 250 : (lineNum < 2 ? SizeLiterals.Screen.screenHeight * 204 / 812 : SizeLiterals.Screen.screenHeight * 226 / 812))
        }
        
        alertIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 16 / 812)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(50)
        }
        
        alertTitleLabel.snp.makeConstraints {
            $0.top.equalTo(alertIcon.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        alertSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(alertTitleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        alertCheckButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 16 / 812)
            $0.centerX.equalToSuperview()
        }
        
        alertCheckButton.snp.updateConstraints {
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 96)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 44 / 812)
        }
    }
}
