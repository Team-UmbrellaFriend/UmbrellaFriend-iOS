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
    private var code: Int = 0
    
    // MARK: - UI Components
    
    private let reportView = ReportView()
    
    // MARK: - Life Cycles
    
    init(viewModel: MypageViewModel) {
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
        bindViewModel()
        setDelegate()
    }
}

// MARK: - Extensions

extension ReportViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }

    func bindViewModel() {
        viewModel.outputs.reportMenuData
            .bind(to: reportView.reportCollectionView.rx
                .items(cellIdentifier: ReportCollectionViewCell.className,
                       cellType: ReportCollectionViewCell.self)) { (index, model, cell) in
                cell.configureCell(model: model)
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
        
        reportView.reportButton.rx.tap
            .bind {
                let num = 3
                var reason = "기타"
                if let selectedIndexPath = self.reportView.reportCollectionView.indexPathsForSelectedItems?.first {
                    switch selectedIndexPath.item {
                    case 0:
                        reason = "분실"
                    case 1:
                        reason = "QR"
                    case 2:
                        reason = "파손"
                    default:
                        break
                    }
                }
                self.viewModel.inputs.report(num: num, reason: reason, description: self.reportView.reportTextView.text)
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.mypageReportMessage
            .subscribe(onNext: { message in
                self.reportView.reportAlertView.isHidden = false
                self.reportView.configureReportAlert(message: message)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.mypageReportCode
            .subscribe(onNext: { code in
                self.code = code
            })
            .disposed(by: disposeBag)
        
    }
    
    func setDelegate() {
        reportView.navigationView.delegate = self
        reportView.reportAlertView.delegate = self
    }
}

extension ReportViewController: NavigationBarProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ReportViewController: CustomAlertButtonDelegate {
    
    func tapCheckButton() {
        self.reportView.reportAlertView.isHidden = true
        if code == 201 {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
