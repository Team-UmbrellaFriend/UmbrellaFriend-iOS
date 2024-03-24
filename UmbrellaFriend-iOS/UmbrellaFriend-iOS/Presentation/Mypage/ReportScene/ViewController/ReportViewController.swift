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
    }
    
    func setDelegate() {
        reportView.navigationView.delegate = self
    }
}

// MARK: - Network

extension ReportViewController: NavigationBarProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
