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
    
    private var backButtonAction: (() -> Void)?
    
    // MARK: - UI Components
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .btnBack), for: .normal)
        button.isHidden = true
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
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
        addSubview(backButton)
    }
    
    func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
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
