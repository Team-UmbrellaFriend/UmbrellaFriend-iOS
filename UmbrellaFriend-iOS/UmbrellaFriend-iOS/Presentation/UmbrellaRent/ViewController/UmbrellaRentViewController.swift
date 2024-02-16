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
        setAddTarget()
    }
}

// MARK: - Extensions

private extension UmbrellaRentViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setAddTarget() {
        umbrellaRentView.exitButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        umbrellaRentView.mapButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        switch sender {
        case umbrellaRentView.exitButton:
            self.navigationController?.popViewController(animated: true)
        case umbrellaRentView.mapButton:
            print("📍")
        default:
            break
        }
    }
}
