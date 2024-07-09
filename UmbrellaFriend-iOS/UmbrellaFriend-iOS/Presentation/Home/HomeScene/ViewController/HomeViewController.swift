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
import WidgetKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var isFromSplash: Bool = false
    private var isNotRent: Bool = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindUI()
        bindViewModel()
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
        
        homeView.notReturnView.rx.tapGesture()
            .when(.recognized)
            .subscribe(with: self, onNext: { owner, _ in
                owner.setReturnToastMessage()
            }).disposed(by: disposeBag)
        
        self.rx.viewWillAppear
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                LoadingView.shared.show(self.view)
            })
            .disposed(by: disposeBag)
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    LoadingView.shared.hide()
                    self.setToastMessage()
                }
            })
            .disposed(by: disposeBag)
        
        output.homeData
            .map { homeData in
                return homeData.dDay.daysRemaining < 0
            }
            .subscribe(onNext: { notRent in
                self.isNotRent = notRent
            })
            .disposed(by: disposeBag)
        
        output.homeData
            .map { homeData in
                return homeData.weather.weather.percent
            }
            .subscribe(onNext: { rainPercent in
                UserDefaults.groupShared.set(rainPercent, forKey: "RainPercent")
                WidgetCenter.shared.reloadAllTimelines()
            })
            .disposed(by: disposeBag)
        
        output.homeData
            .map { homeData in
                let dday = homeData.dDay
                if dday.isOverdue {
                    return RentWidgetDto(isRent: true, isOverdue: true, returnDay: dday.overdueDays)
                } else {
                    if dday.daysRemaining < 0 {
                        return RentWidgetDto(isRent: false, isOverdue: false, returnDay: 0)
                    } else {
                        return RentWidgetDto(isRent: true, isOverdue: false, returnDay: dday.daysRemaining)
                    }
                }
            }
            .subscribe(onNext: { rentData in
                self.saveRentData(rentDto: rentData)
                WidgetCenter.shared.reloadAllTimelines()
            })
            .disposed(by: disposeBag)
        
        output.extendMessageData
            .subscribe(onNext: { message in
                self.homeView.homeAlertView.isHidden = false
                self.homeView.configureHomeAlertView(message)
            })
            .disposed(by: disposeBag)
    }
    
    func saveRentData(rentDto: RentWidgetDto) {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(rentDto)
            UserDefaults.groupShared.set(encoded, forKey: "rentData")
        } catch {
            print("Failed to encode RentWidgetDto: \(error)")
        }
    }
    
    func setToastMessage() {
        if isFromSplash {
            self.isFromSplash = false
            homeView.loginToastMessage.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut, animations: {
                self.homeView.loginToastMessage.alpha = 0.0
            }, completion: {_ in
                self.homeView.loginToastMessage.isHidden = true
                self.homeView.loginToastMessage.alpha = 1.0
            })
        }
    }
    
    func setReturnToastMessage() {
        if isNotRent {
            homeView.returnToastMessage.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut, animations: {
                self.homeView.returnToastMessage.alpha = 0.0
            }, completion: {_ in
                self.homeView.returnToastMessage.isHidden = true
                self.homeView.returnToastMessage.alpha = 1.0
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
        let nav = DIContainer.shared.makeUmbrellaReturnVC()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    private func pushToUmbrellaMapVC() {
        let nav = DIContainer.shared.makeUmbrellaMapVC()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    private func pushToMypageVC() {
        let nav = DIContainer.shared.makeMypageVC()
        self.navigationController?.pushViewController(nav, animated: true)
    }
}
