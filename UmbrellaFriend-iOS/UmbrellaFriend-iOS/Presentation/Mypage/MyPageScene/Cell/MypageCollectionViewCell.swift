//
//  MypageCollectionViewCell.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/2/24.
//

import UIKit

import SnapKit

final class MypageCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let hitoryDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray1000
        label.font = .umbrellaFont(.body4)
        return label
    }()
    
    private let hitoryPeriodLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray1000
        label.font = .umbrellaFont(.body4)
        return label
    }()
    
    private let divideView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray400
        return view
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension MypageCollectionViewCell {

    func setUI() {
        backgroundColor = .clear
    }
    
    func setHierarchy() {
        addSubviews(hitoryDateLabel, hitoryPeriodLabel, divideView)
    }
    
    func setLayout() {
        hitoryDateLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        hitoryPeriodLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }
        
        divideView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}

extension MypageCollectionViewCell {

    func configureCell(model: History) {
        hitoryDateLabel.text = model.rentDate
        hitoryPeriodLabel.text = model.rentalPeriod
    }
}
