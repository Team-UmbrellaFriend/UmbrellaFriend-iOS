//
//  ReportViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/21/24.
//

import UIKit

import RxSwift
import RxCocoa

final class ReportViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: MypageViewModel
    private let disposeBag = DisposeBag()
    private var num: String = ""
    private var isSuccessReport: Bool = false
    
    private let mypageReportSubject = PublishSubject<MypageReportRequestDto>()
    private let reportMenuData = BehaviorRelay<[MypageReportEntity]>(value: MypageReportEntity.mypageReportEntityInitValue())
    
    // MARK: - UI Components
    
    private let reportView = ReportView()
    
    // MARK: - Life Cycles
    
    init(num: String, viewModel: MypageViewModel) {
        self.num = num
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        view = reportView
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

extension ReportViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func bindUI() {
        self.reportMenuData
            .bind(to: reportView.reportCollectionView.rx
                .items(cellIdentifier: ReportCollectionViewCell.className,
                       cellType: ReportCollectionViewCell.self)) { (index, model, cell) in
                cell.configureReportCell(model: model)
            }
                       .disposed(by: disposeBag)
        
        reportView.reportCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                if let selectedCell = self.reportView.reportCollectionView.cellForItem(at: indexPath) as? ReportCollectionViewCell {
                    selectedCell.isSelected = !selectedCell.isSelected
                }
                reportView.reportButton.isEnabled = true
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            reportView.reportCollectionView.rx.itemSelected,
            reportView.reportTextView.rx.text.orEmpty
        )
        .subscribe(onNext: { [weak self] indexPath, text in
            guard let self = self else { return }
            
            if !text.isEmpty {
                if let selectedCell = self.reportView.reportCollectionView.cellForItem(at: indexPath) as? ReportCollectionViewCell {
                    selectedCell.isSelected = false
                }
            }
        })
        .disposed(by: disposeBag)
        
        let reportButtonTapped = reportView.reportButton.rx.tap.asObservable()
        
        let selectedIndexPathObservable = reportView.reportCollectionView.rx.itemSelected
            .map { $0.item }
            .startWith(-1)
        
        let reasonObservable = selectedIndexPathObservable.map { selectedIndex in
            switch selectedIndex {
            case 0:
                return "분실"
            case 1:
                return "QR"
            case 2:
                return "파손"
            default:
                return "기타"
            }
        }
        
        let descriptionObservable = reportView.reportTextView.rx.text.orEmpty.asObservable()
        
        Observable.combineLatest(reportButtonTapped, reasonObservable, descriptionObservable)
            .subscribe(onNext: { [weak self] _, reason, description in
                guard let self = self else { return }
                self.mypageReportSubject.onNext(MypageReportRequestDto(umbrellaNumber: self.num, reportReason: reason, description: description))
            })
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let input = MypageViewModel.Input(
            viewWillAppearEvent: Observable.empty(),
            logoutButtonTapped: Observable.empty(),
            reportButtonTapped: self.mypageReportSubject.asObserver(), 
            withdrawButtonTapped: Observable.empty()
        )
        
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
        
        output.mypageReportData
            .subscribe(onNext: { message in
                self.reportView.reportAlertView.isHidden = false
                self.isSuccessReport = self.reportView.configureReportAlert(message: message)
            })
            .disposed(by: disposeBag)
    }
    
    func setDelegate() {
        reportView.navigationView.delegate = self
        reportView.reportAlertView.delegate = self
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
}

extension ReportViewController: NavigationBarProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ReportViewController: CustomAlertButtonDelegate {
    
    func tapCheckButton() {
        reportView.reportAlertView.isHidden = true
        if isSuccessReport {
            changeRootToHomeVC()
        }
    }
}
