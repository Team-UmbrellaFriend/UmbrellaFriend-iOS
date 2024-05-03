//
//  LoginViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/17/24.
//

import UIKit

import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    private var isSuccessLogin: Bool = false
    
    // MARK: - UI Components
    
    private let loginView = LoginView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        setDelegate()
        setGesture()
    }
}

// MARK: - Extensions

extension LoginViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func bindViewModel() {
        loginViewModel.outputs.userLoginData
            .subscribe(onNext: { model in
                UserManager.shared.updateToken(model.token)
            })
            .disposed(by: disposeBag)
        
        loginViewModel.outputs.loginMessage
            .subscribe(onNext: { message in
                self.isSuccessLogin = self.loginView.configureLoginView(message: message)
                if self.isSuccessLogin {
                    self.changeRootToHomeVC()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setDelegate() {
        loginView.navigationView.delegate = self
        loginView.loginButton.delegate = self
        loginView.idTextField.delegate = self
        loginView.pwTextField.delegate = self
    }
    
    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func changeRootToHomeVC() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                let homeViewController = DIContainer.shared.makeHomeVC()
                let navigationController = UINavigationController(rootViewController: homeViewController)
                window.rootViewController = navigationController
            }
        }
    }
}

extension LoginViewController: NavigationBarProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension LoginViewController: ButtonProtocol {
    
    func buttonTapped() {
        loginViewModel.login(id: loginView.idTextField.text ?? "", pw: loginView.pwTextField.text ?? "")
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
}
