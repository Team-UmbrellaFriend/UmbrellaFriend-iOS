//
//  UmbrellaRentBottomSheetViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

import SnapKit
import RxSwift

final class UmbrellaRentBottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    
    private let umbrellaRentViewModel: UmbrellaRentViewModel
    private let umbrellaRentView: UmbrellaRentView
    private let disposeBag = DisposeBag()
    private var bottomHeight: CGFloat = SizeLiterals.Screen.screenHeight * 501 / 812
    
    // MARK: - UI Components
    
    private let umbrellaRentBottomSheetView = UmbrellaRentBottomSheetView()
    
    // MARK: - Initializer
    
    init(viewModel: UmbrellaRentViewModel, view: UmbrellaRentView) {
        self.umbrellaRentViewModel = viewModel
        self.umbrellaRentView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = umbrellaRentBottomSheetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAPI()
        setUI()
        bindViewModel()
        setDismissAction()
        setAddTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
    }
}

// MARK: - Extensions

extension UmbrellaRentBottomSheetViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }

    func bindViewModel() {
        umbrellaRentViewModel.outputs.umbrellaCheckData
            .asDriver()
            .drive(onNext: { [weak self] model in
                self?.umbrellaRentBottomSheetView.configureBottomSheetView(model: model)
            })
            .disposed(by: disposeBag)
        
        umbrellaRentBottomSheetView.rentProgressButton.rx.tap
            .subscribe(onNext: {
                self.umbrellaRentViewModel.inputs.umbrellaLend(number: Int(self.umbrellaRentView.number) ?? 0)
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
            self.umbrellaRentBottomSheetView.bottomSheetView.snp.remakeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight - self.bottomHeight)
            }
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.umbrellaRentBottomSheetView.backgroundView.backgroundColor = .umbrellaBlack.withAlphaComponent(0.6)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func hideBottomSheet() {
        DispatchQueue.main.async {
            self.umbrellaRentBottomSheetView.bottomSheetView.snp.remakeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
            }
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.umbrellaRentBottomSheetView.backgroundView.backgroundColor = .clear
                self.view.layoutIfNeeded()
            }, completion: { _ in
                if self.presentingViewController != nil {
                    self.umbrellaRentView.isProcessingMetadata = false
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    func setDismissAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideBottomSheetAction))
        umbrellaRentBottomSheetView.backgroundView.addGestureRecognizer(tapGesture)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(hideBottomSheetAction))
        swipeGesture.direction = .down
        umbrellaRentBottomSheetView.addGestureRecognizer(swipeGesture)
    }
    
    @objc
    func hideBottomSheetAction() {
        hideBottomSheet()
    }
    
    func setAddTarget() {
        umbrellaRentBottomSheetView.rentCancelButton.addTarget(self, action: #selector(hideBottomSheetAction), for: .touchUpInside)
    }
}

// MARK: - Network

extension UmbrellaRentBottomSheetViewController {

    func getAPI() {
        
    }
}
