//
//  UmbrellaReturnBottomSheetViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

import RxSwift
import RxCocoa
import RxGesture

final class UmbrellaReturnBottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    
    private let umbrellaPlace: [UmbrellaReturnPlaceEntity] = UmbrellaReturnPlaceEntity.umbrellaReturnPlace()
    private let disposeBag = DisposeBag()
    private var bottomHeight: CGFloat = SizeLiterals.Screen.screenHeight * 395 / 812
    private let returnViewModel: UmbrellaReturnViewModel
    
    var selectedIndexPath: IndexPath?
    var returnQRPlace: Int = 0
    private let umbrellaReturnSubject = PublishSubject<UmbrellaReturnRequestDto>()
    
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
        
        setDelegate()
        setCollectionView()
        bindUI()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
    }
}

// MARK: - Extensions

extension UmbrellaReturnBottomSheetViewController {
    
    func setDelegate() {
        umbrellaReturnBottomSheetView.umbrellaReturnAlertView.delegate = self
    }
    
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
                
                self.checkPlaceSelect(indexPath.item + 1)
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
    }
    
    func bindUI() {
        umbrellaReturnBottomSheetView.backgroundView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                self.hideBottomSheet()
            }
            .disposed(by: disposeBag)
        
        umbrellaReturnBottomSheetView.bottomSheetView.rx.swipeGesture(.down)
            .when(.recognized)
            .bind { _ in
                self.hideBottomSheet()
            }
            .disposed(by: disposeBag)
        
        umbrellaReturnBottomSheetView.umbrellaReturnCompleteView.goHomeButton.rx.tap
            .subscribe(onNext: {
                self.changeRootToHomeVC()
            })
            .disposed(by: disposeBag)
        
        umbrellaReturnBottomSheetView.returnProgressButton.rx.tap
            .map {
                switch self.selectedIndexPath?.item {
                case 0:
                    return "명신관"
                case 1:
                    return "르네상스관"
                case 2:
                    return "과학관"
                default:
                    return ""
                }
            }
            .subscribe(onNext: { location in
                self.umbrellaReturnSubject.onNext(UmbrellaReturnRequestDto(location: location))
            })
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let input = UmbrellaReturnViewModel.Input(
            returnQrCodeCaptured: umbrellaReturnSubject.asObserver()
        )
        
        let output = returnViewModel.transform(from: input, disposeBag: disposeBag)
        
        output.umbrellaReturnCode
            .map { status in
                return status == 200
            }
            .subscribe(onNext: { isReturnSuccess in
                if isReturnSuccess {
                    self.umbrellaReturnBottomSheetView.umbrellaReturnCompleteView.isHidden = false
                }
            })
            .disposed(by: disposeBag)
    }
    
    func checkPlaceSelect(_ selectedIndex: Int) {
        if returnQRPlace < 0 || returnQRPlace == selectedIndex {
            umbrellaReturnBottomSheetView.returnProgressButton.isEnabled = true
            umbrellaReturnBottomSheetView.umbrellaReturnAlertView.isHidden = true
        } else {
            umbrellaReturnBottomSheetView.returnProgressButton.isEnabled = false
            umbrellaReturnBottomSheetView.umbrellaReturnAlertView.isHidden = false
        }
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
    
    func changeRootToHomeVC() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                let homeViewController = DIContainer.shared.makeHomeVC()
                let navigationController = UINavigationController(rootViewController: homeViewController)
                window.rootViewController = navigationController
            }
        }
    }
}

extension UmbrellaReturnBottomSheetViewController: CustomAlertButtonDelegate {
    
    func tapCheckButton() {
        umbrellaReturnBottomSheetView.umbrellaReturnAlertView.isHidden = true
    }
}
