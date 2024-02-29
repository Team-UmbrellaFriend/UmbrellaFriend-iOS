//
//  UmbrellaReturnBottomSheetViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

final class UmbrellaReturnBottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    
    
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
        setHierarchy()
        setLayout()
        setDelegate()
    }
}

// MARK: - Extensions

extension UmbrellaReturnBottomSheetViewController {

    func setUI() {
        
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

extension UmbrellaReturnBottomSheetViewController {

    func getAPI() {
        
    }
}
