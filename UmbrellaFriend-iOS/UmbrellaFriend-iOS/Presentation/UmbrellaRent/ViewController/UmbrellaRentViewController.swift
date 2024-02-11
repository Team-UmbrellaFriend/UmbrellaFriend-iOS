//
//  UmbrellaRentViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/11/24.
//

import UIKit

final class UmbrellaRentViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let umbrellaRentView = UmbrellaRentView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = umbrellaRentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
}

// MARK: - Extensions

extension UmbrellaRentViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
}
