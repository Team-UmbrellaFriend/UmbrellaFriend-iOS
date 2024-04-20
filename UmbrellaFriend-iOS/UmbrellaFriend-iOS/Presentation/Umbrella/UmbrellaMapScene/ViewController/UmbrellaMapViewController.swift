//
//  UmbrellaMapViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/26/24.
//

import UIKit

import RxSwift
import RxCocoa

final class UmbrellaMapViewController: UIViewController {
    
    // MARK: - Properties
    
    private let umbrellaMapViewModel: UmbrellaMapViewModel
    private let disposeBag = DisposeBag()
    private let mapTappedSubject = PublishSubject<Int>()
    
    // MARK: - UI Components
    
    private let umbrellaMapView = UmbrellaMapView()
    
    // MARK: - Life Cycles
    
    init(viewModel: UmbrellaMapViewModel) {
        self.umbrellaMapViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        view = umbrellaMapView
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

extension UmbrellaMapViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func bindUI() {
        let mapIcons = [umbrellaMapView.mapIcon1, umbrellaMapView.mapIcon2, umbrellaMapView.mapIcon3]

        mapIcons.enumerated().forEach { index, mapBtn in
            mapBtn.rx.tap
                .map { index }
                .bind(to: mapTappedSubject)
                .disposed(by: disposeBag)
        }
    }
    
    func bindViewModel() {
        let input = UmbrellaMapViewModel.Input(
            viewWillAppearEvent: self.rx.viewWillAppear.asObservable(),
            mapIconTapped: self.mapTappedSubject.asObserver()
        )
        
        let output = self.umbrellaMapViewModel.transform(from: input, disposeBag: self.disposeBag)
        
        output.umbrellaMapData
            .subscribe(onNext: { mapData in
                self.umbrellaMapView.configureUmbrellaMapView(model: mapData)
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
