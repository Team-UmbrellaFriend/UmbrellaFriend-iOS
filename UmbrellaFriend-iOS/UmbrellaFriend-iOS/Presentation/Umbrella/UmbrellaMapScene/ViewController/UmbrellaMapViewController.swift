//
//  UmbrellaMapViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/26/24.
//

import UIKit

final class UmbrellaMapViewController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - UI Components
    
    private let umbrellaMapView = UmbrellaMapView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = umbrellaMapView
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

extension UmbrellaMapViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setHierarchy() {
        
    }
    
    func setLayout() {
        
    }
    
    func setDelegate() {
        
    }
}

// MARK: - Network

extension UmbrellaMapViewController {

    func getAPI() {
        
    }
}
