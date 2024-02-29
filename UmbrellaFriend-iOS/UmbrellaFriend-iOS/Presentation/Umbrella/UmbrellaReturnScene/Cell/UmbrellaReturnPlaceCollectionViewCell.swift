//
//  UmbrellaReturnPlaceCollectionViewCell.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

import SnapKit

final class UmbrellaReturnPlaceCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let placeImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 24
        return image
    }()
    
    let placeLabel: UILabel = {
        let label = UILabel()
        label.text = "명신관"
        label.textColor = .umbrellaWhite
        label.textAlignment = .center
        label.font = .umbrellaFont(.body3)
        label.backgroundColor = .umbrellaBlack.withAlphaComponent(0.7)
        label.clipsToBounds = true
        label.layer.cornerRadius = 16
        return label
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

private extension UmbrellaReturnPlaceCollectionViewCell {

    func setUI() {
        backgroundColor = .clear
    }
    
    func setHierarchy() {
        placeImageView.addSubview(placeLabel)
        addSubview(placeImageView)
    }
    
    func setLayout() {
        placeImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(166)
        }
        
        placeLabel.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(12)
            $0.width.equalTo(57)
            $0.height.equalTo(30)
        }
    }
    
    func calculateLabelWidth(for model: UmbrellaPlaceDto) -> CGFloat {
        let text = model.placeTitle
        let font = UIFont.umbrellaFont(.body3)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let textSize = (text as NSString).size(withAttributes: attributes)
        return textSize.width + 16
    }
}

extension UmbrellaReturnPlaceCollectionViewCell {

    func configureCell(model: UmbrellaPlaceDto) {
        placeImageView.image = UIImage(named: model.placeImage)
        placeLabel.text = model.placeTitle
        
        let labelWidth = calculateLabelWidth(for: model)
        placeLabel.snp.updateConstraints {
            $0.width.equalTo(labelWidth)
        }
    }
}
