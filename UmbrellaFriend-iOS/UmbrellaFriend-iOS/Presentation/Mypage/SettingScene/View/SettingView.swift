//
//  SettingView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/25/24.
//

import UIKit

import SnapKit

final class SettingView: UIView {
    
    // MARK: - UI Components
    
    let navigationView: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.isBackButtonIncluded = true
        return nav
    }()
    
    private let settingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "설정"
        label.textAlignment = .left
        label.textColor = .umbrellaBlack
        label.font = .umbrellaFont(.heading3)
        return label
    }()
    
    private let settingSupportHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "도움"
        label.textAlignment = .left
        label.textColor = .gray600
        label.font = .umbrellaFont(.body5)
        return label
    }()
    
    let settingSupportTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.rowHeight = 52
        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }()
    
    private let divideView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    
    private let settingAccountHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "계정설정"
        label.textAlignment = .left
        label.textColor = .gray600
        label.font = .umbrellaFont(.body5)
        return label
    }()
    
    let settingAccountTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .none
        tableView.rowHeight = 52
        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setRegisterCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension SettingView {

    func setUI() {
        backgroundColor = .umbrellaWhite
    }
    
    func setHierarchy() {
        addSubviews(navigationView, settingTitleLabel, 
                    settingSupportHeaderLabel, settingSupportTableView,
                    divideView, settingAccountHeaderLabel, settingAccountTableView)
    }
    
    func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        settingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(13)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(22)
        }
        
        settingSupportHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(settingTitleLabel.snp.bottom).offset(40)
            $0.leading.equalTo(settingTitleLabel.snp.leading)
        }
        
        settingSupportTableView.snp.makeConstraints {
            $0.top.equalTo(settingSupportHeaderLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(208)
        }
        
        divideView.snp.makeConstraints {
            $0.top.equalTo(settingSupportTableView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        
        settingAccountHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(divideView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(22)
        }
        
        settingAccountTableView.snp.makeConstraints {
            $0.top.equalTo(settingAccountHeaderLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(104)
        }
    }
    
    func setRegisterCell() {
        SettingTableViewCell.register(target: settingSupportTableView)
        SettingTableViewCell.register(target: settingAccountTableView)
    }
}
