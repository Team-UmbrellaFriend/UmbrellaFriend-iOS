//
//  UmbrellaMapViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/26/24.
//

import UIKit

import RxSwift

final class UmbrellaMapViewController: UIViewController {
    
    // MARK: - Properties
    
    private let umbrellaMapViewModel = UmbrellaMapViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let umbrellaMapView = UmbrellaMapView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = umbrellaMapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        setDelegate()
    }
}

// MARK: - Extensions

extension UmbrellaMapViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func bindViewModel() {
        let mapIcons = [umbrellaMapView.mapIcon1, umbrellaMapView.mapIcon2, umbrellaMapView.mapIcon3, umbrellaMapView.mapIcon4, umbrellaMapView.mapIcon5, umbrellaMapView.mapIcon6]
        
        for (index, button) in mapIcons.enumerated() {
            button.rx.tap
                .bind { [weak self] in
                    guard let self = self else { return }
                    self.umbrellaMapViewModel.inputs.mapIconTapped(with: index + 1)
                }
                .disposed(by: disposeBag)
        }
        
        umbrellaMapViewModel.outputs.umbrellaAvailableData
            .asDriver()
            .drive(onNext: { [weak self] model in
                self?.umbrellaMapView.configureUmbrellaMapView(model: model)
            })
            .disposed(by: disposeBag)
    }
    
    func setDelegate() {
        umbrellaMapView.navigationView.delegate = self
    }
}


extension UmbrellaMapViewController: NavigationBarProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
