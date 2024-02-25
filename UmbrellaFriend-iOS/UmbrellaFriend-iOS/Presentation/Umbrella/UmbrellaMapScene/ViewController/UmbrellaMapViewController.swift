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
        
        setUI()
        setAddTarget()
        setDelegate()
    }
}

// MARK: - Extensions

extension UmbrellaMapViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setAddTarget() {
        [umbrellaMapView.mapIcon1, umbrellaMapView.mapIcon2, umbrellaMapView.mapIcon3, umbrellaMapView.mapIcon4, umbrellaMapView.mapIcon5, umbrellaMapView.mapIcon6].forEach {
            $0.addTarget(self, action: #selector(mapIconTapped), for: .touchUpInside)
        }
    }
    
    @objc
    func mapIconTapped(_ sender: UIButton) {
        switch sender {
        case umbrellaMapView.mapIcon1:
            print("1")
        case umbrellaMapView.mapIcon2:
            print("2")
        case umbrellaMapView.mapIcon3:
            print("3")
        case umbrellaMapView.mapIcon4:
            print("4")
        case umbrellaMapView.mapIcon5:
            print("5")
        case umbrellaMapView.mapIcon6:
            print("6")
        default:
            break
        }
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
