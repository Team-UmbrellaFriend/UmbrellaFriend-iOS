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
        setDelegate()
    }
}

// MARK: - Extensions

extension LogoViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func setAddTarget() {
        logoView.signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
    }
    
    func setDelegate() {
        logoView.loginButton.delegate = self
    }
    
    @objc
    func signupTapped() {
        let nav = PhotoAttachViewController()
        self.navigationController?.pushViewController(nav, animated: true)
    }
}

extension LogoViewController: ButtonProtocol {
    
    func buttonTapped() {
        let nav = LoginViewController()
        self.navigationController?.pushViewController(nav, animated: true)
    }
}
