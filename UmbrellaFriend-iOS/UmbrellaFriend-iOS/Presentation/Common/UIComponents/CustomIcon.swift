//
//  CustomIcon.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/21/24.
//

import UIKit

import SnapKit

final class CustomIcon: UIView {
    
    // MARK: - Properties
    
    enum CustomIconType {
        case homeProfile
        case homeRent
        case homeReturn
        case homeMap
        case mypageProfile
        
        var viewColor: UIColor {
            switch self {
            case .homeProfile:
                return .umbrellaWhite
            case .homeRent:
                return .umbrellaWhite.withAlphaComponent(0.6)
            case .homeReturn:
                return .umbrellaWhite.withAlphaComponent(0.9)
            case .homeMap:
                return .darkOrange
            case .mypageProfile:
                return .mainBlue
            }
        }
        
        var viewSize: CGFloat {
            switch self {
            case .homeProfile:
                return 56
            case .homeRent, .homeReturn, .homeMap:
                return 54
            case .mypageProfile:
                return 80
            }
        }
        
        var iconImage: UIImage {
            switch self {
            case .homeProfile:
                return UIImage(resource: .graphicProfile)
            case .homeRent:
                return UIImage(resource: .icUnfoldUmbrella)
            case .homeReturn:
                return UIImage(resource: .icFoldUmbrella)
            case .homeMap:
                return UIImage(resource: .icHomePlace)
            case .mypageProfile:
                return UIImage(resource: .graphicMypage)
            }
        }
        
        var iconSize: CGSize {
            switch self {
            case .homeProfile:
                return CGSize(width: 26, height: 44)
            case .homeRent, .homeReturn, .homeMap:
                return CGSize(width: 32, height: 32)
            case .mypageProfile:
                return CGSize(width: 38, height: 62)
            }
        }
    }
    
    var returnDay: Int = 0 {
        didSet {
            setBorrowUI(day: self.returnDay)
        }
    }
    
    // MARK: - UI Components
    
    private let iconImage = UIImageView()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = .umbrellaFont(.subtitle1)
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(type: CustomIconType) {
        self.init()
        
        setUI(type: type)
    }
}

// MARK: - Extensions

private extension CustomIcon {
    
    func setUI(type: CustomIconType) {
        self.backgroundColor = type.viewColor
        self.layer.cornerRadius = 25
        self.iconImage.image = type.iconImage
        
        self.addSubviews(iconImage, dayLabel)
        self.snp.makeConstraints {
            $0.size.equalTo(type.viewSize)
        }
        self.iconImage.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(type.iconSize)
        }
        self.dayLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        iconImage.isHidden = false
        dayLabel.isHidden = true
    }
    
    func setBorrowUI(day: Int) {
        iconImage.isHidden = true
        dayLabel.isHidden = false
        
        if day == 0 {
            setUI(type: .homeReturn)
        } else if day > 0 {
            dayLabel.text = "D+\(day)"
            dayLabel.textColor = .subOrange
        } else {
            dayLabel.text = "D\(day)"
            dayLabel.textColor = .mainBlue
        }
    }
}
