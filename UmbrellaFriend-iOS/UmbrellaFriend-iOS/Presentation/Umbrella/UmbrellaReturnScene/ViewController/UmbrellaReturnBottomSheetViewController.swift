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
    private let returnViewModel: UmbrellaReturnViewModel
    var selectedIndexPath: IndexPath?
    
    var returnPhotoPlace: Int = 0
    
    // MARK: - UI Components
    
    private let umbrellaReturnBottomSheetView = UmbrellaReturnBottomSheetView()
    
    // MARK: - Initializer
    
    init(viewModel: UmbrellaReturnViewModel) {
        self.returnViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = umbrellaReturnBottomSheetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func setCollectionView() {
        Observable.just(umbrellaPlace)
            .bind(to: umbrellaReturnBottomSheetView.returnPlaceCollectionView.rx
                .items(cellIdentifier: UmbrellaReturnPlaceCollectionViewCell.className,
                       cellType: UmbrellaReturnPlaceCollectionViewCell.self)) { (index, model, cell) in
                cell.configureCell(model: self.umbrellaPlace[index])
                cell.isSelected = false
            }
            .disposed(by: disposeBag)
        
        umbrellaReturnBottomSheetView.returnPlaceCollectionView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                if let selectedIndexPath = self.selectedIndexPath {
                    self.umbrellaReturnBottomSheetView.returnPlaceCollectionView.deselectItem(at: selectedIndexPath, animated: false)
                    if let deselectedCell = self.umbrellaReturnBottomSheetView.returnPlaceCollectionView.cellForItem(at: selectedIndexPath) as? UmbrellaReturnPlaceCollectionViewCell {
                        deselectedCell.setBorder(.nonselected)
                    }
                }
                
                if self.returnPhotoPlace != indexPath.item + 1 {
                    let nav = UmbrellaReturnAlertViewController()
                    nav.modalPresentationStyle = .overFullScreen
                    self.present(nav, animated: false)
                }
                
                self.selectedIndexPath = indexPath
                if let selectedCell = self.umbrellaReturnBottomSheetView.returnPlaceCollectionView.cellForItem(at: indexPath) as? UmbrellaReturnPlaceCollectionViewCell {
                    selectedCell.setBorder(.selected)
                }
            })
            .disposed(by: disposeBag)
        
        umbrellaReturnBottomSheetView.returnPlaceCollectionView.rx.itemDeselected
            .subscribe(onNext: { indexPath in
                if let deselectedCell = self.umbrellaReturnBottomSheetView.returnPlaceCollectionView.cellForItem(at: indexPath) as? UmbrellaReturnPlaceCollectionViewCell {
                    deselectedCell.setBorder(.nonselected)
                }
            })
            .disposed(by: disposeBag)
        
        umbrellaReturnBottomSheetView.returnProgressButton.rx.tap
            .subscribe(onNext: {
                self.returnViewModel.umbrellaReturn()
                self.umbrellaReturnBottomSheetView.umbrellaReturnCompleteView.isHidden = false
            })
            .disposed(by: disposeBag)
        
        umbrellaReturnBottomSheetView.umbrellaReturnCompleteView.goHomeButton.rx.tap
            .subscribe(onNext: {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    if let window = windowScene.windows.first {
                        let homeViewController = HomeViewController()
                        let navigationController = UINavigationController(rootViewController: homeViewController)
                        window.rootViewController = navigationController
                    }
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
