//
//  MypageViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/2/24.
//

import UIKit

import RxSwift
import RxCocoa

final class MypageViewController: UIViewController {
    
    // MARK: - Properties
    
    private let mypageViewModel = MypageViewModel()
    private let disposeBag = DisposeBag()
    private var id: Int = 0
    
    // MARK: - UI Components
    
    private let mypageView = MypageView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = mypageView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mypageViewModel.inputs.reloadMypage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        setDelegate()
    }
}

// MARK: - Extensions

extension MypageViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    func bindViewModel() {
        mypageViewModel.outputs.mypageData
            .asDriver()
            .drive(onNext: { [weak self] model in
                self?.mypageView.configureView(model: model)
                self?.id = model.user.id
            })
            .disposed(by: disposeBag)
        
        mypageViewModel.outputs.mypageData
            .bind(to: mypageView.historyCollectionView.rx
                .items(cellIdentifier: MypageCollectionViewCell.className,
                       cellType: MypageCollectionViewCell.self)) { (index, model, cell) in
                cell.configureCell(model: model)
            }
            .disposed(by: disposeBag)
        
        mypageView.navigationView.logoutButton.rx.tap
            .subscribe(onNext: {
                self.mypageViewModel.inputs.logout()
            })
            .disposed(by: disposeBag)
        
        mypageViewModel.outputs.logoutData
            .subscribe(onNext: { _ in
                UserManager.shared.clearToken()
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    if let window = windowScene.windows.first {
                        let homeViewController = SplashViewController()
                        let navigationController = UINavigationController(rootViewController: homeViewController)
                        window.rootViewController = navigationController
                    }
                }
            })
            .disposed(by: disposeBag)
        
        mypageView.profileEditButton.rx.tap
            .subscribe(onNext: {
                let nav = SignupViewController(idx: self.id)
                nav.isAllValid = [true, true, true, true, false, false]
                self.navigationController?.pushViewController(nav, animated: true)
            })
            .disposed(by: disposeBag)
        
        mypageView.reportButton.rx.tap
            .bind {
                let nav = ReportNumberViewController(viewModel: self.mypageViewModel)
                self.navigationController?.pushViewController(nav, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func setDelegate() {
        mypageView.navigationView.delegate = self
    }
}

extension MypageViewController: NavigationBarProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
