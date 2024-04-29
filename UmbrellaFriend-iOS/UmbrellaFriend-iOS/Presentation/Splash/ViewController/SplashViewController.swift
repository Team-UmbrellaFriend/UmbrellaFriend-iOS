//
//  SplashViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/16/24.
//

import UIKit

import RxSwift
import RxCocoa

final class SplashViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let splashView = SplashView()
    
    private let viewModel: SplashViewModel
    private let disposeBag = DisposeBag()
    private let myVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    private let appStoreURL = "itms-apps://itunes.apple.com/app/id6479554833"
    
    // MARK: - Life Cycles
    
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindUI()
        bindViewModel()
    }
}

// MARK: - Extensions

extension SplashViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func bindUI() {
        splashView.forceUpdateAlert.alertCheckButton.rx.tap
            .subscribe(onNext: { _ in
                self.openAppStore(urlStr: self.appStoreURL)
            })
            .disposed(by: disposeBag)
        
        splashView.recommendOkButton.rx.tap
            .subscribe(onNext: { _ in
                self.openAppStore(urlStr: self.appStoreURL)
            })
            .disposed(by: disposeBag)
        
        splashView.recommendCancelButton.rx.tap
            .subscribe(onNext: { _ in
                self.showNextPage()
            })
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let input = SplashViewModel.Input(
            viewWillAppearEvent: self.rx.viewWillAppear.asObservable()
        )
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
        
        output.versionData
            .map { entity in
                return VersionDto(recommendVersion: entity.iosVersion.appVersion,
                                  forceVeresion: entity.iosVersion.forceUpdateVersion)
            }
            .subscribe(onNext: { dto in
                UserManager.shared.updateStoreVersion(dto.recommendVersion)
                if !self.splashView.bindUpdateAlert(myVersion: self.myVersion ?? "", version: dto) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.showNextPage()
                    }
                }
            })
            .disposed(by: disposeBag)
    }

    func showNextPage() {
        if UserManager.shared.hasToken {
            let nav = DIContainer.shared.makeHomeVC()
            nav.isFromSplash = true
            self.navigationController?.pushViewController(nav, animated: true)
        } else {
            let nav = LogoViewController()
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
    
    func openAppStore(urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
