//
//  SplashViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/16/24.
//

import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let splashView = SplashView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            self.showNextPage()
        }
    }
}

// MARK: - Extensions

extension SplashViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }

    func showNextPage() {
        if UserManager.shared.hasToken {
            let nav = HomeViewController()
            nav.isFromSplash = true
            self.navigationController?.pushViewController(nav, animated: true)
        } else {
            let nav = LogoViewController()
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
}
