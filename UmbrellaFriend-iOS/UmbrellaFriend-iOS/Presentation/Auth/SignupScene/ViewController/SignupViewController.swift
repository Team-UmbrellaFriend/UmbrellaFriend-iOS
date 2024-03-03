//
//  SignupViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/18/24.
//

import UIKit

import RxSwift
import RxCocoa

final class SignupViewController: UIViewController {
    
    // MARK: - Properties
    
    var extractName: String = ""
    var extractId: String = ""
    var isAllValid: [Bool] = [true, true, false, false, false, false]
    
    var userId: Int = 0
    
    private let signupViewModel = SignupViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let signupView = SignupView()
    
    // MARK: - Initializer
    
    init(_ idx: Int) {
        self.userId = idx
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = signupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        setDelegate()
        setTextField()
        setGesture()
    }
}

// MARK: - Extensions

extension SignupViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        signupView.signupTitleLabel.text = self.userId > 0  ? "프로필 수정" : "기본 정보를\n입력해주세요."
    }
    
    func bindViewModel() {
        if self.userId > 0 { // 프로필 수정
            self.signupView.nameTextField.isUserInteractionEnabled = false
            self.signupView.idTextField.isUserInteractionEnabled = false
            signupViewModel.inputs.userProfile(id: self.userId)
            signupViewModel.outputs.userProfileData
                .subscribe(onNext: { [weak self] model in
                    self?.signupView.configureView(model: model)
                })
                .disposed(by: disposeBag)
        }
        
        signupView.completeButton.rx.tap
            .subscribe(onNext: {
                if self.userId > 0 {
                    print("프로필 수정")
                } else {
                    print("회원가입")
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setDelegate() {
        signupView.navigationView.delegate = self
        signupView.nameTextField.delegate = self
        signupView.idTextField.delegate = self
        signupView.phoneTextField.delegate = self
        signupView.emailTextField.delegate = self
        signupView.pwTextField.delegate = self
        signupView.pwCheckTextField.delegate = self
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
    
    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func isPasswordConfirmed(password: String, confirmPassword: String) -> Bool {
        return password == confirmPassword
    }
    
    func validateTextField(textField: UITextField, isValid: Bool, type: Int) {
        if isValid {
            if let customTextField = textField as? CustomTextField {
                customTextField.textFieldStatus = .editing
            }
            self.isAllValid[type] = true
        } else {
            if let customTextField = textField as? CustomTextField {
                customTextField.textFieldStatus = .uncorrectedType
            }
            self.isAllValid[type] = false
        }
    }
    
    func updateCompletButton() {
        if isAllValid.allSatisfy({ $0 }) {
            signupView.completeButton.isEnabled = true
        } else {
            signupView.completeButton.isEnabled = false
        }
    }
}

// MARK: - Network

extension SignupViewController: NavigationBarProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        
        switch textField {
        case signupView.nameTextField:
            validateTextField(textField: textField, isValid: newText.isValidName(), type: 0)
        case signupView.idTextField:
            validateTextField(textField: textField, isValid: newText.isValidStudentID(), type: 1)
        case signupView.phoneTextField:
            validateTextField(textField: textField, isValid: newText.isValidPhoneNumber(), type: 2)
        case signupView.emailTextField:
            validateTextField(textField: textField, isValid: newText.isValidEmail(), type: 3)
        case signupView.pwTextField:
            validateTextField(textField: textField, isValid: newText.isValidPassword(), type: 4)
        case signupView.pwCheckTextField:
            validateTextField(textField: textField, isValid: isPasswordConfirmed(password: signupView.pwTextField.text ?? "", confirmPassword: newText), type: 5)
        default:
            break
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let currentText = textField.text ?? ""
        if currentText.isEmpty {
            if let customTextField = textField as? CustomTextField {
                customTextField.textFieldStatus = .normal
            }
        }
        updateCompletButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
}
