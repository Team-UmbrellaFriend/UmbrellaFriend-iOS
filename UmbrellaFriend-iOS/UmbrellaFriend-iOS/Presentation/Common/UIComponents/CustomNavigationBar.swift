//
//  CustomNavigationBar.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/17/24.
//

import UIKit

import SnapKit

protocol NavigationBarProtocol: AnyObject {
    
    func tapBackButton()
}

final class CustomNavigationBar: UIView {
    
    // MARK: - Properties
    
    weak var delegate: NavigationBarProtocol?
    
    var isBackButtonIncluded: Bool {
        get { !backButton.isHidden }
        set { backButton.isHidden = !newValue }
    }
    
    var isTitleLabelIncluded: Bool {
        get { !titleLabel.isHidden }
        set { titleLabel.isHidden = !newValue }
    }
    
    var isAgainButtonInclued: Bool {
        get { !againButton.isHidden }
        set { againButton.isHidden = !newValue }
    }
    
    private var backButtonAction: (() -> Void)?
    
    // MARK: - UI Components
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .icLeft), for: .normal)
        button.isHidden = true
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "우산 대여 지도"
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.title1)
        label.isHidden = true
        return label
    }()
    
    private lazy var againButton: UIButton = {
        let button = UIButton()
        button.setTitle("다시찍기", for: .normal)
        button.titleLabel?.font = .umbrellaFont(.body2)
        button.setTitleColor(.gray350, for: .normal)
        button.isHidden = true
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension CustomNavigationBar {

    func setUI() {
        backgroundColor = .umbrellaWhite
    }
    
    func setHierarchy() {
        addSubviews(backButton, titleLabel, againButton)
    }
    
    func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        againButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(69)
            $0.height.equalTo(48)
        }
    }
    
    func setAddTarget() {
        backButton.addTarget(self, action: #selector(isTapped), for: .touchUpInside)
    }
    
    @objc
    func isTapped() {
        delegate?.tapBackButton()
    }
}
