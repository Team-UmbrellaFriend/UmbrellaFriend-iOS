//
//  HomeViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/21/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var fromSplash: Bool = false
    
    // MARK: - UI Components
    
    private let homeView = HomeView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
}

// MARK: - Extensions

extension HomeViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
}
