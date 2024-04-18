//
//  LoadingView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/17/24.
//

import UIKit

import Lottie
import SnapKit
import Kingfisher

final class LoadingView: UIView {
    
    // MARK: - Properties
    
    static let shared = LoadingView()
    
    // MARK: - UI Components
    
    private let loadingSplashView: LottieAnimationView = LottieAnimationView(name: "LoadingLottie")

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

private extension LoadingView {
    
    func setUI() {
        self.backgroundColor = .umbrellaBlack.withAlphaComponent(0.7)
        
        loadingSplashView.frame = bounds
        loadingSplashView.center = center
        loadingSplashView.contentMode = .scaleAspectFit
        loadingSplashView.backgroundColor = .clear
        loadingSplashView.loopMode = .loop
    }
    
    func setHierarchy() {
        addSubview(loadingSplashView)
    }
    
    func setLayout() {
        loadingSplashView.snp.makeConstraints {
            $0.size.equalTo(SizeLiterals.Screen.screenWidth)
            $0.center.equalToSuperview()
        }
    }
}

extension LoadingView {
    
    func show(_ view: UIView) {
        view.addSubview(self)
        
        self.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        loadingSplashView.play()
        self.layoutIfNeeded()
    }

    func hide() {
        self.removeFromSuperview()
        loadingSplashView.stop()
    }
}
