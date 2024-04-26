//
//  WithdrawViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 4/24/24.
//

import UIKit

import RxSwift
import RxCocoa

final class WithdrawViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: MypageViewModel
    private let disposeBag = DisposeBag()
    private let withdrawReasonData = BehaviorRelay<[MypageWithdrawEntity]>(value: MypageWithdrawEntity.mypageWithdrawEntityInitValue())
    
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
        
        getAPI()
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
    }
}

// MARK: - Extensions

extension WithdrawViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func bindUI() {
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
        
//        Observable.combineLatest(
//            withdrawView.
//            withdrawView.withdrawReasonCollectionView.rx.itemSelected,
//            withdrawView.withdrawReasonTextView.rx.text.orEmpty
//        )
//        .subscribe(onNext: { [weak self] indexPath, text in
//            guard let self = self else { return }
//            
//            if !text.isEmpty {
//                if let selectedCell = self.reportView.reportCollectionView.cellForItem(at: indexPath) as? ReportCollectionViewCell {
//                    selectedCell.isSelected = false
//                }
//            }
//        })
//        .disposed(by: disposeBag)
    }
    
    func setHierarchy() {
        
    }
    
    func setLayout() {
        
    }
    
    func setDelegate() {
        
    }
}

// MARK: - Network

extension WithdrawViewController {

    func getAPI() {
        
    }
}
