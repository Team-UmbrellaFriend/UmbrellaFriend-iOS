//
//  UmbrellaReturnPlaceCollectionViewCell.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

import SnapKit

enum PlaceSelectType {
    case nonselected
    case selected
    
    var borderColor: CGColor {
        switch self {
        case .nonselected:
            return UIColor.clear.cgColor
        case .selected:
            return UIColor.mainBlue.cgColor
        }
    }
    
    var labelColor: UIColor {
        switch self {
        case .nonselected:
            return .umbrellaBlack.withAlphaComponent(0.7)
        case .selected:
            return .mainBlue
        }
    }
}

final class UmbrellaReturnPlaceCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let placeImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 24
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.clear.cgColor
        return image
    }()
    
    let placeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .umbrellaWhite
        label.textAlignment = .center
        label.font = .umbrellaFont(.body3)
        label.backgroundColor = .umbrellaBlack.withAlphaComponent(0.7)
        label.clipsToBounds = true
        label.layer.cornerRadius = 16
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.clear.cgColor
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
    
    func setBorder(_ type: PlaceSelectType) {
        self.placeImageView.layer.borderColor = type.borderColor
        self.placeLabel.backgroundColor = type.labelColor
    }
}
