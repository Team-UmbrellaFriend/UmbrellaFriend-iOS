//
//  ReportNumberViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/25/24.
//

import UIKit

import RxSwift
import RxCocoa
import RxGesture

final class ReportNumberViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: MypageViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let reportNumberView = ReportNumberView()
    
    // MARK: - Initializer
    
    init(viewModel: MypageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = reportNumberView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        setDelegate()
    }
}

// MARK: - Extensions

extension ReportNumberViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    func bindViewModel() {
        reportNumberView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                self.reportNumberView.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        reportNumberView.nextButton.rx.tap
            .bind {
                let nav = ReportViewController(num: self.reportNumberView.numberTextField.text ?? "", viewModel: self.viewModel)
                self.navigationController?.pushViewController(nav, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func setDelegate() {
        reportNumberView.navigationView.delegate = self
        reportNumberView.numberTextField.delegate = self
    }
}

extension ReportNumberViewController: NavigationBarProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ReportNumberViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        if newText.isValidNumber() {
            if let customTextField = textField as? CustomTextField {
                customTextField.textFieldStatus = .editing
            }
        } else {
            if let customTextField = textField as? CustomTextField {
                customTextField.textFieldStatus = .uncorrectedType
            }
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
        reportNumberView.nextButton.isEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
}
