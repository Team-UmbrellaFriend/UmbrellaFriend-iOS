//
//  LogoViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/16/24.
//

import UIKit

final class LogoViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let logoView = LogoView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = logoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setAddTarget()
    }
}

// MARK: - Extensions

extension LogoViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func setAddTarget() {
        logoView.loginButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        logoView.signupButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        switch sender {
        case logoView.loginButton:
            let nav = LoginViewController()
            self.navigationController?.pushViewController(nav, animated: true)
        case logoView.signupButton:
            let nav = PhotoAttachViewController()
            nav.fromLoginView = true
            self.navigationController?.pushViewController(nav, animated: true)
        default:
            break
        }
    }
}
