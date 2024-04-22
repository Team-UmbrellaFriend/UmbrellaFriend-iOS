//
//  UmbrellaRentBottomSheetViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import RxGesture

final class UmbrellaRentBottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    
    private let umbrellaRentViewModel: UmbrellaRentViewModel
    private var umbrellaNum: Int = -1
    private let umbrellaRentView: UmbrellaRentView
    private let disposeBag = DisposeBag()
    private var bottomHeight: CGFloat = SizeLiterals.Screen.screenHeight * 501 / 812
    private let umbrellaLendSubject = PublishSubject<Int>()
    private var isSuccessLend: Bool = false
    
    // MARK: - UI Components
    
    private let umbrellaRentBottomSheetView = UmbrellaRentBottomSheetView()
    
    // MARK: - Initializer
    
    init(viewModel: UmbrellaRentViewModel, view: UmbrellaRentView, umbrellaNum: Int) {
        self.umbrellaRentViewModel = viewModel
        self.umbrellaRentView = view
        self.umbrellaNum = umbrellaNum
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = umbrellaRentBottomSheetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindUI()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
    }
}

// MARK: - Extensions

extension UmbrellaRentBottomSheetViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.umbrellaRentBottomSheetView.rentAlertView.delegate = self
    }
    
    func bindUI() {
        umbrellaRentBottomSheetView.rentProgressButton.rx.tap
            .map { self.umbrellaNum }
            .bind(to: umbrellaLendSubject)
            .disposed(by: disposeBag)
        
        umbrellaRentBottomSheetView.rentCancelButton.rx.tap
            .subscribe(onNext: { _ in
                self.hideBottomSheet()
            })
            .disposed(by: disposeBag)
        
        umbrellaRentBottomSheetView.backgroundView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                self.hideBottomSheet()
            }
            .disposed(by: disposeBag)
        
        umbrellaRentBottomSheetView.bottomSheetView.rx.swipeGesture(.down)
            .when(.recognized)
            .bind { _ in
                self.hideBottomSheet()
            }
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let input = UmbrellaRentViewModel.Input(
            qrCodeCaptured: Observable.just(self.umbrellaNum),
            lendButtonTapped: self.umbrellaLendSubject.asObserver()
        )
        
        let output = umbrellaRentViewModel.transform(from: input, disposeBag: disposeBag)
        
        output.umbrellaCheckData
            .asDriver(onErrorJustReturn: UmbrellaCheckEntity.umbrellaCheckInitValue())
            .drive(with: self, onNext: { owner, checkData in
                owner.umbrellaRentBottomSheetView.configureBottomSheetView(checkData)
            })
            .disposed(by: disposeBag)
        
        output.umbrellaLendMessage
            .subscribe(onNext: { message in
                self.isSuccessLend = self.umbrellaRentBottomSheetView.configureAlertView(message: message)
                if !self.isSuccessLend {
                    self.umbrellaRentBottomSheetView.rentAlertView.isHidden = false
                } else {
                    self.changeRootToHomeVC()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func showBottomSheet() {
        DispatchQueue.main.async {
            self.umbrellaRentBottomSheetView.bottomSheetView.snp.remakeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight - self.bottomHeight)
            }
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.umbrellaRentBottomSheetView.backgroundView.backgroundColor = .umbrellaBlack.withAlphaComponent(0.6)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func hideBottomSheet() {
        DispatchQueue.main.async {
            self.umbrellaRentBottomSheetView.bottomSheetView.snp.remakeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
            }
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.umbrellaRentBottomSheetView.backgroundView.backgroundColor = .clear
                self.view.layoutIfNeeded()
            }, completion: { _ in
                if self.presentingViewController != nil {
                    self.umbrellaRentView.isProcessingMetadata = false
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
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

extension UmbrellaRentBottomSheetViewController: CustomAlertButtonDelegate {
    
    func tapCheckButton() {
        umbrellaRentBottomSheetView.rentAlertView.isHidden = true
    }
}
