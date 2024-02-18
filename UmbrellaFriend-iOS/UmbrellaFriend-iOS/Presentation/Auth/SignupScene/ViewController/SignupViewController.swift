//
//  SignupViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/18/24.
//

import UIKit

final class SignupViewController: UIViewController {
    
    // MARK: - Properties
    
    var extractName: String = ""
    var extractId: String = ""
    
    // MARK: - UI Components
    
    private let signupView = SignupView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = signupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setTextField()
    }
}

// MARK: - Extensions

extension SignupViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        signupView.navigationView.delegate = self
    }
    
    func setAddTarget() {
        signupView.completeButton.addTarget(self, action: #selector(completeTapped), for: .touchUpInside)
    }
    
    @objc
    func completeTapped() {
        
    }
    
    func setTextField() {
        signupView.nameTextField.text = extractName
        signupView.idTextField.text = extractId
    }
}

// MARK: - Network

extension SignupViewController: NavigationBarProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
