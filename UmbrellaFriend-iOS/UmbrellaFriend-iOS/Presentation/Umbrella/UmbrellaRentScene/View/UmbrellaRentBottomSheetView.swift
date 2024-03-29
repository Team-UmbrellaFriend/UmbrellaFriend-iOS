//
//  UmbrellaRentBottomSheetView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/28/24.
//

import UIKit

import SnapKit

final class UmbrellaRentBottomSheetView: UIView {
    
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
    
    private let rentTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "우산을 정말로 대여할까요?"
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.title1)
        return label
    }()
    
    private let umbrellaInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainBlue
        label.textAlignment = .center
        label.font = .umbrellaFont(.subtitle1)
        label.backgroundColor = .lightBlue
        label.clipsToBounds = true
        label.layer.cornerRadius = 17
        return label
    }()
    
    private let rentInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let rentUserNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.subtitle1)
        return label
    }()
    
    private let rentUserStudentIDLabel: UILabel = {
        let label = UILabel()
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.body4)
        return label
    }()
    
    private let rentDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.body4)
        return label
    }()
    
    lazy var rentCancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.umbrellaWhite, for: .normal)
        button.setBackgroundColor(.gray400, for: .normal)
        button.setBackgroundColor(.gray500, for: .highlighted)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .umbrellaFont(.subtitle1)
        return button
    }()
    
    lazy var rentProgressButton: UIButton = {
        let button = UIButton()
        button.setTitle("대여하기", for: .normal)
        button.setTitleColor(.umbrellaWhite, for: .normal)
        button.setBackgroundColor(.mainBlue, for: .normal)
        button.setBackgroundColor(.darkBlue, for: .highlighted)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .umbrellaFont(.subtitle1)
        return button
    }()
    
    private let rentIcon = UIImageView(image: UIImage(resource: .icBigUmbrella))
    let rentAlertView = CustomAlertView(subTitle: "")
    
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

private extension UmbrellaRentBottomSheetView {

    func setUI() {
        backgroundColor = .clear
        rentAlertView.isHidden = true
    }
    
    func setHierarchy() {
        rentInfoView.addSubviews(rentUserNameLabel, rentUserStudentIDLabel, rentDateLabel)
        bottomSheetView.addSubviews(rentTitleLabel, rentIcon, umbrellaInfoLabel, rentInfoView, rentCancelButton, rentProgressButton)
        addSubviews(backgroundView, bottomSheetView, rentAlertView)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheetView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        rentTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.centerX.equalToSuperview()
        }
        
        rentIcon.snp.makeConstraints {
            $0.top.equalTo(rentTitleLabel.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(100)
        }
        
        umbrellaInfoLabel.snp.makeConstraints {
            $0.top.equalTo(rentIcon.snp.bottom).offset(17)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(122)
            $0.height.equalTo(34)
        }
        
        rentInfoView.snp.makeConstraints {
            $0.top.equalTo(umbrellaInfoLabel.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 27 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 33)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 114 / 812)
        }
        
        rentUserNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 19 / 812)
            $0.centerX.equalToSuperview()
        }
        
        rentUserStudentIDLabel.snp.makeConstraints {
            $0.top.equalTo(rentUserNameLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        rentDateLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 19 / 812)
            $0.centerX.equalToSuperview()
        }
        
        rentCancelButton.snp.makeConstraints {
            $0.top.equalTo(rentInfoView.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 10 / 812)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 40) / 2)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 54 / 812)
        }
        
        rentProgressButton.snp.makeConstraints {
            $0.top.equalTo(rentInfoView.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 10 / 812)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 40) / 2)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 54 / 812)
        }
        
        rentAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension UmbrellaRentBottomSheetView {
    
    func configureBottomSheetView(model: UmbrellaCheckDto) {
        umbrellaInfoLabel.text = model.umbrellaNum < 10 ? "우산 번호 0\(model.umbrellaNum)" : "우산 번호 \(model.umbrellaNum)"
        rentUserNameLabel.text = model.username
        rentUserStudentIDLabel.text = "\(model.studentID)"
        rentDateLabel.text = "\(model.date) (3일 대여)"
        rentDateLabel.partColorChange(targetString: "(3일 대여)", textColor: .subOrange)
    }
    
    func configureAlertView(subTitle: String) {
        rentAlertView.alertSubTitleLabel.text = "\(subTitle).\nQR코드를 다시 인식해주세요."
    }
}
