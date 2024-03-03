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
    
    // MARK: - UI Components
    
    private let mypageView = MypageView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = mypageView
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
    }

    func bindViewModel() {
        mypageViewModel.outputs.mypageData
            .asDriver()
            .drive(onNext: { [weak self] model in
                self?.mypageView.configureView(model: model)
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
                print("logout")
            })
            .disposed(by: disposeBag)
        
        mypageView.profileEditButton.rx.tap
            .subscribe(onNext: {
                self.mypageViewModel.outputs.mypageData
                    .subscribe(onNext: { [weak self] model in
                        let nav = SignupViewController(model.user.id)
                        self?.navigationController?.pushViewController(nav, animated: true)
                    })
                    .disposed(by: self.disposeBag)
            })
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
