//
//  UmbrellaRentBottomSheetViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

final class UmbrellaRentBottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    
    private let umbrellaRentViewModel: UmbrellaRentViewModel
    
    // MARK: - UI Components
    
    private let umbrellaRentBottomSheetView = UmbrellaRentBottomSheetView()
    
    // MARK: - Initializer
    
    init(viewModel: UmbrellaRentViewModel) {
        self.umbrellaRentViewModel = viewModel
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
        setHierarchy()
        setLayout()
        setDelegate()
    }
}

// MARK: - Extensions

extension UmbrellaRentBottomSheetViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }

    func bindViewModel() {
        
    }
    
    func setHierarchy() {
        
    }
    
    func setLayout() {
        
    }
    
    func setDelegate() {
        
    }
}

// MARK: - Network

extension UmbrellaRentBottomSheetViewController {

    func getAPI() {
        
    }
}