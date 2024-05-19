//
//  UmbrellaReturnViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

import RxSwift
import RxCocoa

final class UmbrellaReturnViewController: UIViewController {
    
    // MARK: - Properties
    
    private var qrPlaceId: Int = 0
    private let returnViewModel: UmbrellaReturnViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let umbrellaReturnView = UmbrellaReturnView()
    
    // MARK: - Life Cycles
    
    init(viewModel: UmbrellaReturnViewModel) {
        self.returnViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        view = umbrellaReturnView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindUI()
        setDelegate()
    }
}

// MARK: - Extensions

extension UmbrellaReturnViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func bindUI() {
        umbrellaReturnView.exitButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.popVC()
            }).disposed(by: disposeBag)
        
        umbrellaReturnView.showPlaceButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                self.qrPlaceId = -1
                owner.pushToReturnBottomSheetVC()
            }).disposed(by: disposeBag)
    }

    func setDelegate() {
        umbrellaReturnView.delegate = self
        umbrellaReturnView.returnCameraAccessAlertView.delegate = self
    }
}

extension UmbrellaReturnViewController: UmbrellaReturnDelegate {
    
    func didExtractPlace(_ placeId: Int) {
        self.qrPlaceId = placeId
        pushToReturnBottomSheetVC()
    }
}

extension UmbrellaReturnViewController: CustomAlertButtonDelegate {
    
    func tapCheckButton() {
        guard let settingURL = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(settingURL) else { return }
        UIApplication.shared.open(settingURL, options: [:])
    }
}

extension UmbrellaReturnViewController {
    
    func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func pushToReturnBottomSheetVC() {
        let nav = UmbrellaReturnBottomSheetViewController(viewModel: self.returnViewModel, view: self.umbrellaReturnView)
        nav.returnQRPlace = self.qrPlaceId
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: false)
    }
}
