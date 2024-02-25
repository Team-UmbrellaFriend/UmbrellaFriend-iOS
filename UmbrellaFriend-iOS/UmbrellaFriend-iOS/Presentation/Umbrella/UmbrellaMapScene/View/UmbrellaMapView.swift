//
//  UmbrellaMapView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/26/24.
//

import UIKit

import SnapKit

final class UmbrellaMapView: UIView {

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
    lazy var mapIcon4 = UIButton()
    lazy var mapIcon5 = UIButton()
    lazy var mapIcon6 = UIButton()
    
    private let mapDetailView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100.withAlphaComponent(0.85)
        view.clipsToBounds = true
        view.layer.cornerRadius = 35
        return view
    }()
    
    private let mapDetailTitle: UILabel = {
        let label = UILabel()
        label.text = "명신관 우산 잔여 개수"
        label.textColor = .gray800
        label.font = .umbrellaFont(.subtitle1)
        return label
    }()
    
    private let mapDetailSubTitle: UILabel = {
        let label = UILabel()
        label.text = "정확한 위치 정보"
        label.textColor = .gray800
        label.font = .umbrellaFont(.body5)
        return label
    }()
    
    private let umbrellaNumberView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlue
        view.clipsToBounds = true
        view.layer.cornerRadius = 42
        return view
    }()
    
    private let umbrellaNumberTitle: UILabel = {
        let label = UILabel()
        label.text = "현재 개수"
        label.textColor = .umbrellaWhite
        label.font = .umbrellaFont(.body2)
        return label
    }()
    
    private let umbrellaNumberSubTitle: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.textColor = .umbrellaWhite
        label.font = .umbrellaFont(.heading2)
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
         // '명신관': 1, '순헌관': 2, '학생회관': 3, '도서관': 4, '음대': 5, '백주년기념관': 6
        [mapIcon1, mapIcon2, mapIcon3, mapIcon4, mapIcon5, mapIcon6].forEach {
            $0.setImage(.icPlace, for: .normal)
            $0.setImage(.icPlace, for: .highlighted)
            $0.snp.makeConstraints {
                $0.size.equalTo(44)
            }
        }
    }
    
    func setHierarchy() {
        horizontalScrollView.addSubviews(mapImage, mapIcon1, mapIcon2, mapIcon3, mapIcon4, mapIcon5, mapIcon6)
        umbrellaNumberView.addSubviews(umbrellaNumberTitle, umbrellaNumberSubTitle)
        mapDetailView.addSubviews(mapDetailTitle, mapDetailSubTitle, umbrellaNumberView)
        addSubviews(navigationView, horizontalScrollView, mapDetailView)
    }
    
    func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
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
            $0.top.equalToSuperview().inset(115)
            $0.trailing.equalToSuperview().inset(418)
        }
        
        mapIcon2.snp.makeConstraints {
            $0.top.equalToSuperview().inset(264)
            $0.trailing.equalToSuperview().inset(258)
        }
        
        mapIcon3.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(406)
            $0.bottom.equalToSuperview().inset(228)
        }
        
        mapIcon4.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(168)
            $0.bottom.equalToSuperview().inset(151)
        }
        
        mapIcon5.snp.makeConstraints {
            $0.top.equalToSuperview().inset(155)
            $0.leading.equalToSuperview().inset(190)
        }
        
        mapIcon6.snp.makeConstraints {
            $0.top.equalToSuperview().inset(320)
            $0.leading.equalToSuperview().inset(69)
        }
        
        mapDetailView.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-SizeLiterals.Screen.screenHeight * 36 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 32)
            $0.height.equalTo(120)
        }
        
        mapDetailTitle.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        
        mapDetailSubTitle.snp.makeConstraints {
            $0.top.equalTo(mapDetailTitle.snp.bottom).offset(4)
            $0.leading.equalTo(mapDetailTitle.snp.leading)
        }
        
        umbrellaNumberView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(88)
        }
        
        umbrellaNumberTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        umbrellaNumberSubTitle.snp.makeConstraints {
            $0.top.equalTo(umbrellaNumberTitle.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
}
