//
//  UmbrellaMapView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/26/24.
//

import UIKit

import SnapKit

final class UmbrellaMapView: UIView {
    
    // MARK: - Properties
    
    private var isBigRatio: Bool = SizeLiterals.Screen.deviceRatio > 0.5 ? true : false

    // MARK: - UI Components
    
    let navigationView: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.isBackButtonIncluded = true
        nav.isTitleLabelIncluded = true
        return nav
    }()
    
    private lazy var horizontalScrollView = UIScrollView()
    private let mapImage = UIImageView(image: UIImage(resource: .graphicMap))
    lazy var mapIcon1 = UIButton()
    lazy var mapIcon2 = UIButton()
    lazy var mapIcon3 = UIButton()
    
    private let mapDetailTitle: UILabel = {
        let label = UILabel()
        label.text = "대여 장소를 선택해주세요."
        label.textColor = .gray800
        label.font = .umbrellaFont(.subtitle1)
        return label
    }()
    
    private let mapDetailSubTitle: UILabel = {
        let label = UILabel()
        label.text = "세부 장소를 알려드려요."
        label.textColor = .gray800
        label.font = .umbrellaFont(.body5)
        return label
    }()
    
    private let umbrellaNumberTitle: UILabel = {
        let label = UILabel()
        label.text = "0개"
        label.textColor = .umbrellaWhite
        label.textAlignment = .center
        label.font = .umbrellaFont(.heading3)
        label.backgroundColor = .gray500
        label.clipsToBounds = true
        label.layer.cornerRadius = 24
        return label
    }()
    
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

private extension UmbrellaMapView {

    func setUI() {
        backgroundColor = .umbrellaWhite
        mapImage.image = isBigRatio ? .graphicMapS : .graphicMap
        horizontalScrollView.showsHorizontalScrollIndicator = false
        horizontalScrollView.bounces = false
         // '명신관': 1, '르네상스관': 2, '과학관': 3
        [mapIcon1, mapIcon2, mapIcon3].forEach {
            $0.setImage(isBigRatio ? .icPlaceS : .icPlace, for: .normal)
            $0.setImage(isBigRatio ? .icPlaceS : .icPlace, for: .highlighted)
            $0.snp.makeConstraints {
                $0.size.equalTo(isBigRatio ? 48 : 44)
            }
        }
    }
    
    func setHierarchy() {
        horizontalScrollView.addSubviews(mapImage, mapIcon1, mapIcon2, mapIcon3)
        addSubviews(navigationView, horizontalScrollView, mapDetailTitle, mapDetailSubTitle, umbrellaNumberTitle)
    }
    
    func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        horizontalScrollView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        mapImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mapIcon1.snp.makeConstraints {
            $0.top.equalToSuperview().inset(isBigRatio ? 52 : 115)
            $0.trailing.equalToSuperview().inset(isBigRatio ? 225 : 418)
        }
        
        mapIcon2.snp.makeConstraints {
            $0.top.equalToSuperview().inset(isBigRatio ? 83 : 155)
            $0.leading.equalToSuperview().inset(isBigRatio ? 206 : 275)
        }
        
        mapIcon3.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(isBigRatio ? 164 : 220)
            $0.bottom.equalToSuperview().inset(isBigRatio ? 65 : 60)
        }
        
        mapDetailTitle.snp.makeConstraints {
            $0.top.equalTo(mapImage.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(28)
        }
        
        mapDetailSubTitle.snp.makeConstraints {
            $0.top.equalTo(mapDetailTitle.snp.bottom).offset(4)
            $0.leading.equalTo(mapDetailTitle.snp.leading)
        }
        
        umbrellaNumberTitle.snp.makeConstraints {
            $0.top.equalTo(mapImage.snp.bottom).offset(19)
            $0.trailing.equalToSuperview().inset(28)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 84 / 375)
            $0.height.equalTo(64)
        }
    }
}

extension UmbrellaMapView {
    
    func configureUmbrellaMapView(model: UmbrellaAvailableEntity){
        mapDetailTitle.text = "\(model.locationName) 우산 잔여 개수"
        mapDetailSubTitle.text = model.locationDetail
        umbrellaNumberTitle.text = "\(model.numUmbrellas)개"
        umbrellaNumberTitle.backgroundColor =
        switch model.numUmbrellas {
        case 0:
            UIColor.umbrellaError
        case 1, 2:
            UIColor.subOrange
        default:
            UIColor.mainBlue
        }
    }
}
