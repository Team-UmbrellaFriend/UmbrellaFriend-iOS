//
//  UmbrellaRentViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/11/24.
//

import UIKit

import RxSwift
import RxCocoa

final class UmbrellaRentViewController: UIViewController {
    
    // MARK: - Properties
    
    private let umbrellaRentViewModel: UmbrellaRentViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let umbrellaRentView = UmbrellaRentView()
    
    // MARK: - Life Cycles
    
    init(viewModel: UmbrellaRentViewModel) {
        self.umbrellaRentViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        view = umbrellaRentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindUI()
        setDelegate()
    }
}

// MARK: - Extensions

private extension UmbrellaRentViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func bindUI() {
        umbrellaRentView.exitButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.popVC()
            }).disposed(by: disposeBag)
        
        umbrellaRentView.mapButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.pushToUmbrellaMapVC()
            }).disposed(by: disposeBag)
    }
    
    func setDelegate() {
        umbrellaRentView.delegate = self
        umbrellaRentView.rentCameraAccessAlertView.delegate = self
    }
}

extension UmbrellaRentViewController: UmbrellaRentDelegate {
    
    func didExtractNumber(_ number: String) {
        presentUmbrellaRentBottomSheetVC(num: Int(number) ?? -1)
    }
}

extension UmbrellaRentViewController: CustomAlertButtonDelegate {
    
    func tapCheckButton() {
        guard let settingURL = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(settingURL) else { return }
        UIApplication.shared.open(settingURL, options: [:])
    }
}

extension UmbrellaRentViewController {
    
    func presentUmbrellaRentBottomSheetVC(num: Int) {
        let nav = UmbrellaRentBottomSheetViewController(viewModel: self.umbrellaRentViewModel, view: self.umbrellaRentView, umbrellaNum: num)
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: false)
    }
    
    func pushToUmbrellaMapVC() {
        let nav = DIContainer.shared.makeUmbrellaMapVC()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
}
