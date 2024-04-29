//
//  SettingViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/25/24.
//

import UIKit

import RxSwift
import RxCocoa
import SafariServices

final class SettingViewController: UIViewController {
    
    // MARK: - Properties
    
    private let settingSupportMenu = BehaviorSubject<[SettingMenuEntity]>(value: SettingMenuEntity.settingSupportValue())
    private let settingAccountMenu = BehaviorSubject<[SettingMenuEntity]>(value: SettingMenuEntity.settingAccountValue())
    private let disposeBag = DisposeBag()
    private let viewModel: MypageViewModel
    
    private let logoutSubject = PublishSubject<Void>()
    private let myVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    // MARK: - UI Components
    
    private let settingView = SettingView()
    
    // MARK: - Life Cycles
    
    init(viewModel: MypageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setTableView()
        bindViewModel()
        setDelegate()
    }
}

// MARK: - Extensions

extension SettingViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func setTableView() {
        self.settingSupportMenu
            .bind(to: settingView.settingSupportTableView.rx
                .items(cellIdentifier: SettingTableViewCell.className,
                       cellType: SettingTableViewCell.self)) { (index, model, cell) in
                cell.configureSettingCell(menu: model)
            }
            .disposed(by: disposeBag)
        
        settingView.settingSupportTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.bindButton(idx: indexPath.row, tableView: self.settingView.settingSupportTableView)
            })
            .disposed(by: disposeBag)
        
        self.settingAccountMenu
            .bind(to: settingView.settingAccountTableView.rx
                .items(cellIdentifier: SettingTableViewCell.className,
                       cellType: SettingTableViewCell.self)) { (index, model, cell) in
                cell.configureSettingCell(menu: model)
            }
            .disposed(by: disposeBag)
        
        settingView.settingAccountTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.bindButton(idx: indexPath.row, tableView: self.settingView.settingAccountTableView)
            })
            .disposed(by: disposeBag)
        
        settingView.settingSupportTableView.rx.willDisplayCell
            .subscribe(onNext: { [self] cell, indexPath in
                guard indexPath.row == 1, let cell = cell as? SettingTableViewCell else { return }
                cell.bindVersionCell(myVersion: self.myVersion ?? "", isSameAppversion: self.myVersion == UserManager.shared.getStoreVersion)
            })
            .disposed(by: self.disposeBag)
    }
    
    func bindButton(idx: Int, tableView: UITableView) {
        switch tableView {
        case settingView.settingSupportTableView:
            switch idx {
            case 0:
                self.pushToReportVC()
            case 2:
                if let url = URL(string: "https://seed-cantaloupe-7de.notion.site/314515f247014f8d9baf20012b10e944?pvs=4") {
                    let safariViewController = SFSafariViewController(url: url)
                    self.present(safariViewController, animated: true, completion: nil)
                }
            case 3:
                if let url = URL(string: "https://seed-cantaloupe-7de.notion.site/a5f353664d1d4196a6abb5ef2943c7e7?pvs=4") {
                    let safariViewController = SFSafariViewController(url: url)
                    self.present(safariViewController, animated: true, completion: nil)
                }
            default:
                break
            }
        case settingView.settingAccountTableView:
            switch idx {
            case 0:
                self.logoutSubject.onNext(())
            case 1:
                self.pushToWithdrawVC()
            default:
                break
            }
        default:
            break
        }
    }
    
    func bindViewModel() {
        let input = MypageViewModel.Input(
            viewWillAppearEvent: Observable.empty(),
            logoutButtonTapped: self.logoutSubject.asObserver(),
            reportButtonTapped: Observable.empty(),
            withdrawButtonTapped: Observable.empty()
        )
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
        
        output.logoutData
            .subscribe(onNext: { _ in
                UserManager.shared.clearToken()
                self.changeRootToSplashVC()
            })
            .disposed(by: disposeBag)
    }
    
    func setDelegate() {
        settingView.navigationView.delegate = self
    }
    
    func pushToReportVC() {
        let nav = ReportNumberViewController(viewModel: self.viewModel)
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    func pushToWithdrawVC() {
        let nav = WithdrawViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    func changeRootToSplashVC() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                let spalshVC = DIContainer.shared.makeSpalshVC()
                let navigationController = UINavigationController(rootViewController: spalshVC)
                window.rootViewController = navigationController
            }
        }
    }
}

extension SettingViewController: NavigationBarProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
