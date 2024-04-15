//
//  HomeViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/21/24.
//

import UIKit

import RxCocoa
import RxSwift
import RxGesture

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var isFromSplash: Bool = false
    private let homeViewModel: HomeViewModel
    private let disposeBag = DisposeBag()
    private let umbrellaExtendSubject = PublishSubject<Void>()
    
    // MARK: - UI Components
    
    private let homeView = HomeView()
    
    // MARK: - Life Cycles
    
    init(viewModel: HomeViewModel) {
        self.homeViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        view = homeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindUI()
        bindViewModel()
        setToastMessage()
        setDelegate()
    }
}

// MARK: - Extensions

extension HomeViewController {

    func setUI() {
        self.homeView.extendView.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func bindUI() {
        homeView.extendView.rx.tapGesture()
            .bind(onNext: { _ in
                self.umbrellaExtendSubject.onNext(())
            })
            .disposed(by: disposeBag)
        
        homeView.rentView.rx.tapGesture()
            .when(.recognized)
            .subscribe(with: self, onNext: { owner, _ in
                owner.pushToUmbrellaRentVC()
            }).disposed(by: disposeBag)
        
        homeView.returnView.rx.tapGesture()
            .when(.recognized)
            .subscribe(with: self, onNext: { owner, _ in
                owner.pushToUmbrellaReturnVC()
            }).disposed(by: disposeBag)
        
        homeView.mapView.rx.tapGesture()
            .when(.recognized)
            .subscribe(with: self, onNext: { owner, _ in
                owner.pushToUmbrellaMapVC()
            }).disposed(by: disposeBag)
        
        homeView.goMyPageButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.pushToMypageVC()
            }).disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        
        let input = HomeViewModel.Input(
            viewWillAppearEvent: self.rx.viewWillAppear.asObservable(),
            extendButtonTapped: self.umbrellaExtendSubject.asObserver()
        )
        
        let output = self.homeViewModel.transform(from: input, disposeBag: self.disposeBag)
        
        output.homeData
            .asDriver(onErrorJustReturn: HomeEntity.homeDtoInitValue())
            .drive(with: self, onNext: { owner, home in
                owner.homeView.configureHomeView(home)
            })
            .disposed(by: disposeBag)
        
        output.extendMessageData
            .subscribe(onNext: { message in
                self.homeView.homeAlertView.isHidden = false
                self.homeView.configureHomeAlertView(message)
            })
            .disposed(by: disposeBag)
    }
    
    func setToastMessage() {
        if isFromSplash {
            homeView.toastMessageLabel.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut, animations: {
                self.homeView.toastMessageLabel.alpha = 0.0
            }, completion: {_ in
                self.homeView.toastMessageLabel.isHidden = true
                self.homeView.toastMessageLabel.alpha = 1.0
            })
        }
    }
    
    func setDelegate() {
        homeView.homeAlertView.delegate = self
    }
}

extension HomeViewController: CustomAlertButtonDelegate {
    
    func tapCheckButton() {
        homeView.homeAlertView.isHidden = true
        let homeVC = UINavigationController(
            rootViewController: DIContainer.shared.makeHomeVC()
        )
        UIApplication.shared.changeRootViewController(homeVC)
    }
}

extension HomeViewController {
    
    private func pushToUmbrellaRentVC() {
        let nav = DIContainer.shared.makeUmbrellaRentVC()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    private func pushToUmbrellaReturnVC() {
        let nav = UmbrellaReturnViewController()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    private func pushToUmbrellaMapVC() {
        let nav = DIContainer.shared.makeUmbrellaMapVC()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    private func pushToMypageVC() {
        let nav = MypageViewController()
        self.navigationController?.pushViewController(nav, animated: true)
    }
}
