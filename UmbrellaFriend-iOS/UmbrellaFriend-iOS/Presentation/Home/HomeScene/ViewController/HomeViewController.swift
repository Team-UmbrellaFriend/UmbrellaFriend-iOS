//
//  HomeViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/21/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var isFromSplash: Bool = false
    
    // MARK: - UI Components
    
    private let homeView = HomeView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setGesture()
        setToastMessage()
    }
}

// MARK: - Extensions

extension HomeViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setToastMessage() {
        if isFromSplash {
            homeView.toastMessageLabel.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut, animations: {
                self.homeView.toastMessageLabel.alpha = 0.0
            }, completion: {_ in
                self.homeView.toastMessageLabel.isHidden = true
                self.homeView.toastMessageLabel.alpha = 1.0
            })
        }
    }
    
    func setGesture() {
        let rentTapGesture = UITapGestureRecognizer(target: self, action: #selector(rentTapped))
        homeView.rentView.addGestureRecognizer(rentTapGesture)
        
        let returnTapGesture = UITapGestureRecognizer(target: self, action: #selector(returnTapped))
        homeView.returnView.addGestureRecognizer(returnTapGesture)
        
        let mapTapGesture = UITapGestureRecognizer(target: self, action: #selector(mapTapped))
        homeView.mapView.addGestureRecognizer(mapTapGesture)
    }
    
    @objc
    func rentTapped() {
        let nav = UmbrellaRentViewController()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    @objc
    func returnTapped() {
//        let nav = UmbrellaReturnViewController()
//        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    @objc
    func mapTapped() {
//        let nav = UmbrellaMapViewController()
//        self.navigationController?.pushViewController(nav, animated: true)
    }
}
