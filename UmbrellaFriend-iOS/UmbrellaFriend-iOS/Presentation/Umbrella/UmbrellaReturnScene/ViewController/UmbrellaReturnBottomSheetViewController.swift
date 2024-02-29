//
//  UmbrellaReturnBottomSheetViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

import RxSwift
import RxCocoa

final class UmbrellaReturnBottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    
    private let umbrellaPlace: [UmbrellaPlaceDto] = UmbrellaPlaceDto.umbrellaPlaceDto()
    private let disposeBag = DisposeBag()
    private var bottomHeight: CGFloat = SizeLiterals.Screen.screenHeight * 395 / 812
    
    var returnPhotoPlace: Int = 0
    
    // MARK: - UI Components
    
    private let umbrellaReturnBottomSheetView = UmbrellaReturnBottomSheetView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = umbrellaReturnBottomSheetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAPI()
        setUI()
        bindViewModel()
        setCollectionView()
        setDismissAction()
        setAddTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
    }
}

// MARK: - Extensions

extension UmbrellaReturnBottomSheetViewController {
    
    func setUI() {
        
    }
    
    func bindViewModel() {
        
    }
    
    func setCollectionView() {
        Observable.just(umbrellaPlace)
            .bind(to: umbrellaReturnBottomSheetView.returnPlaceCollectionView.rx
                .items(cellIdentifier: UmbrellaReturnPlaceCollectionViewCell.className,
                       cellType: UmbrellaReturnPlaceCollectionViewCell.self)) { (index, model, cell) in
                cell.configureCell(model: self.umbrellaPlace[index])
            }
                       .disposed(by: disposeBag)
        
        umbrellaReturnBottomSheetView.returnPlaceCollectionView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                if self.returnPhotoPlace != indexPath.item + 1 {
                    let nav = UmbrellaReturnAlertViewController()
                    self.present(nav, animated: false)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func showBottomSheet() {
        DispatchQueue.main.async {
            self.umbrellaReturnBottomSheetView.bottomSheetView.snp.remakeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight - self.bottomHeight)
            }
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.umbrellaReturnBottomSheetView.backgroundView.backgroundColor = .umbrellaBlack.withAlphaComponent(0.6)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func hideBottomSheet() {
        DispatchQueue.main.async {
            self.umbrellaReturnBottomSheetView.bottomSheetView.snp.remakeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
            }
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.umbrellaReturnBottomSheetView.backgroundView.backgroundColor = .clear
                self.view.layoutIfNeeded()
            }, completion: { _ in
                if self.presentingViewController != nil {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    func setDismissAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideBottomSheetAction))
        umbrellaReturnBottomSheetView.backgroundView.addGestureRecognizer(tapGesture)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(hideBottomSheetAction))
        swipeGesture.direction = .down
        umbrellaReturnBottomSheetView.addGestureRecognizer(swipeGesture)
    }
    
    @objc
    func hideBottomSheetAction() {
        hideBottomSheet()
    }
    
    func setAddTarget() {
        umbrellaReturnBottomSheetView.returnCancelButton.addTarget(self, action: #selector(hideBottomSheetAction), for: .touchUpInside)
    }
}

// MARK: - Network

extension UmbrellaReturnBottomSheetViewController {
    
    func getAPI() {
        
    }
}
