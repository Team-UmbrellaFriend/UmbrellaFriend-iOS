//
//  WithdrawViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/24/24.
//

import UIKit

import RxSwift
import RxCocoa
import RxGesture

final class WithdrawViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: MypageViewModel
    private let disposeBag = DisposeBag()
    private let withdrawReasonData = BehaviorRelay<[MypageWithdrawEntity]>(value: MypageWithdrawEntity.mypageWithdrawEntityInitValue())
    private let withdrawSubject = PublishSubject<WithdrawRequestDto>()
    
    private let isChecked = PublishSubject<Bool>()
    private var isSuccessWithdraw: Bool = false
    
    // MARK: - UI Components
    
    private let withdrawView = WithdrawView()
    
    // MARK: - Life Cycles
    
    init(viewModel: MypageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        view = withdrawView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setCollectionView()
        bindUI()
        bindViewModel()
        setDelegate()
    }
}

// MARK: - Extensions

extension WithdrawViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setCollectionView() {
        self.withdrawReasonData
            .bind(to: withdrawView.withdrawReasonCollectionView.rx
                .items(cellIdentifier: ReportCollectionViewCell.className,
                       cellType: ReportCollectionViewCell.self)) { (index, model, cell) in
                cell.configureWithdrawCell(model: model)
            }
            .disposed(by: disposeBag)
        
        withdrawView.withdrawReasonCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                if let selectedCell = self.withdrawView.withdrawReasonCollectionView.cellForItem(at: indexPath) as? ReportCollectionViewCell {
                    selectedCell.isSelected = !selectedCell.isSelected
                }
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            withdrawView.withdrawReasonCollectionView.rx.itemSelected,
            withdrawView.withdrawReasonTextView.rx.text.orEmpty
        )
        .subscribe(onNext: { [weak self] indexPath, text in
            guard let self = self else { return }
            
            if !text.isEmpty {
                if let selectedCell = self.withdrawView.withdrawReasonCollectionView.cellForItem(at: indexPath) as? ReportCollectionViewCell {
                    selectedCell.isSelected = false
                }
            }
        })
        .disposed(by: disposeBag)
        
        Observable.combineLatest(
            withdrawView.withdrawReasonCollectionView.rx.itemSelected.map { _ in true }.startWith(false),
            withdrawView.withdrawReasonTextView.rx.text.orEmpty.map { text in
                return text != "기타사항 (직접 입력)"
            },
            self.isChecked.asObservable()
        )
        .map { isCellSelected, isTextViewFilled, isCheckTapped in
            return (isCellSelected || isTextViewFilled) && isCheckTapped
        }
        .distinctUntilChanged()
        .subscribe(onNext: { [weak self] isEnabled in
            self?.withdrawView.withdrawButton.isEnabled = isEnabled
        })
        .disposed(by: disposeBag)
    }
    
    func bindUI() {
        withdrawView.rx.swipeGesture(.down)
            .when(.recognized)
            .bind { _ in
                self.withdrawView.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        withdrawView.withdrawCheckView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                self.withdrawView.isWithdrawChecked.toggle()
                self.isChecked.onNext(self.withdrawView.isWithdrawChecked)
            }
            .disposed(by: disposeBag)
        
        let withdrawButtonTapped = withdrawView.withdrawButton.rx.tap.asObservable()
        let selectedIndexPathObservable = withdrawView.withdrawReasonCollectionView.rx.itemSelected
            .map { $0.item }
            .startWith(-1)
        let reasonObservable = selectedIndexPathObservable.map { selectedIndex in
            switch selectedIndex {
            case 0:
                return "수량"
            case 1:
                return "관리"
            case 2:
                return "새계정"
            default:
                return "기타"
            }
        }
        let descriptionObservable = withdrawView.withdrawReasonTextView.rx.text.orEmpty.asObservable()
        
        Observable.combineLatest(withdrawButtonTapped, reasonObservable, descriptionObservable)
            .subscribe(onNext: { [weak self] _, reason, description in
                guard let self = self else { return }
                self.withdrawSubject.onNext(WithdrawRequestDto(check: true, withdrawalReason: reason, description: description))
            })
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let input = MypageViewModel.Input(
            viewWillAppearEvent: Observable.empty(),
            logoutButtonTapped: Observable.empty(),
            reportButtonTapped: Observable.empty(),
            withdrawButtonTapped: self.withdrawSubject.asObserver()
        )
        
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
        
        output.withdrawData
            .subscribe(onNext: { message in
                self.withdrawView.withdrawAlertView.isHidden = false
                self.isSuccessWithdraw = self.withdrawView.configureWithdrawAlert(message: message)
            })
            .disposed(by: disposeBag)
    }
    
    func setDelegate() {
        withdrawView.navigationView.delegate = self
        withdrawView.withdrawAlertView.delegate = self
    }
    
    func changeRootToHomeVC() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                let homeVC = DIContainer.shared.makeHomeVC()
                let navigationController = UINavigationController(rootViewController: homeVC)
                window.rootViewController = navigationController
            }
        }
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

extension WithdrawViewController: NavigationBarProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension WithdrawViewController: CustomAlertButtonDelegate {
    
    func tapCheckButton() {
        if isSuccessWithdraw {
            UserManager.shared.clearToken()
            self.changeRootToSplashVC()
        } else {
            self.changeRootToHomeVC()
        }
    }
}
