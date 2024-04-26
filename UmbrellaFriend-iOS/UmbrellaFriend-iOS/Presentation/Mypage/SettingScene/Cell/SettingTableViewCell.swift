//
//  SettingTableViewCell.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/25/24.
//

import UIKit

import SnapKit

final class SettingTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Properties
    
    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.body3)
        return label
    }()
    
    let settingGoButton: UIButton = {
        let button = UIButton()
        button.setImage(.icRightSmall, for: .normal)
        return button
    }()
    
    private let updateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .gray700
        label.font = .umbrellaFont(.body3)
        label.isHidden = true
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

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

private extension SettingTableViewCell {

    func setUI() {
        backgroundColor = .umbrellaWhite
        self.selectionStyle = .none
    }
    
    func setHierarchy() {
        addSubviews(titleLabel, settingGoButton, updateLabel)
    }
    
    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        settingGoButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(4)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        updateLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}

extension SettingTableViewCell {

    func configureSettingCell(menu: SettingMenuEntity) {
        titleLabel.text = menu.settingTitle
    }
}
