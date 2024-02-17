//
//  PhotoAttachViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/17/24.
//

import UIKit

final class PhotoAttachViewController: UIViewController {
    
    // MARK: - Properties
    
    var fromLoginView: Bool = true
    
    // MARK: - UI Components
    
    private let photoAttachView = PhotoAttachView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = photoAttachView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
    }
}

// MARK: - Extensions

extension PhotoAttachViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.photoAttachView.registerTitleLabel.text = self.fromLoginView ? "학생증을\n등록해 인증해주세요." : "반납 완료를 위해\n카메라로 인증해주세요"
    }
    
    func setDelegate() {
        photoAttachView.navigationView.delegate = self
        photoAttachView.registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside
        )
        photoAttachView.nextButton.delegate = self
    }
    
    @objc
    func registerTapped() {
        
    }
}


extension PhotoAttachViewController: NavigationBarProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}


extension PhotoAttachViewController: ButtonProtocol {
    
    func buttonTapped() {
        print("buttonTapped")
    }
}
