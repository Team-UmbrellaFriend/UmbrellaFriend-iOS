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
    private let homeViewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let homeView = HomeView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        setToastMessage()
    }
}

// MARK: - Extensions

extension HomeViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func bindViewModel() {
        homeViewModel.outputs.homeData
            .asDriver()
            .drive(onNext: { [weak self] model in
                self?.homeView.configureHomeView(model: model)
                if model.dDay.isOverdue {
                    self?.homeView.rentView.isHidden = true
                    self?.homeView.extendView.isHidden = false
                    self?.homeView.returnIcon.returnDay = model.dDay.overdueDays
                } else {
                    if model.dDay.daysRemaining < 0 {
                        self?.homeView.rentView.isHidden = false
                        self?.homeView.extendView.isHidden = true
                        self?.homeView.returnIcon.returnDay = 0
                    } else {
                        self?.homeView.rentView.isHidden = true
                        self?.homeView.extendView.isHidden = false
                        self?.homeView.returnIcon.returnDay = -model.dDay.daysRemaining
                    }
                }
            })
            .disposed(by: disposeBag)
        
        homeView.goMyPageButton.rx.tap
            .subscribe(onNext: {
                let nav = MypageViewController()
                self.navigationController?.pushViewController(nav, animated: true)
            })
            .disposed(by: disposeBag)
        
        homeView.rentView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                let nav = UmbrellaRentViewController()
                self.navigationController?.pushViewController(nav, animated: true)
            }
            .disposed(by: disposeBag)
        
        homeView.returnView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                let nav = UmbrellaReturnViewController()
                self.navigationController?.pushViewController(nav, animated: true)
            }
            .disposed(by: disposeBag)
        
        homeView.mapView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                let nav = UmbrellaMapViewController()
                self.navigationController?.pushViewController(nav, animated: true)
            }
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
}
