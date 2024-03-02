//
//  UmbrellaReturnAlertViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

final class UmbrellaReturnAlertViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let umbrellaReturnAlertView = UmbrellaReturnAlertView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = umbrellaReturnAlertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAddTarget()
    }
}

// MARK: - Extensions

extension UmbrellaReturnAlertViewController {

    func setAddTarget() {
        umbrellaReturnAlertView.alertCheckButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc
    func tapButton() {
        self.dismiss(animated: false)
    }
}
