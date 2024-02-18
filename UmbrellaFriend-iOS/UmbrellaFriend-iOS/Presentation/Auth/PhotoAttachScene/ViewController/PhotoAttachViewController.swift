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
        photoAttachView.nextButton.delegate = self
        photoAttachView.registerButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        photoAttachView.imageDeleteButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc
    func tapButton(_ sender: UIButton) {
        switch sender {
        case photoAttachView.registerButton:
            let albumVC = UIImagePickerController()
            albumVC.sourceType = .photoLibrary
            albumVC.delegate = self
            albumVC.allowsEditing = true
            self.present(albumVC, animated: true, completion: nil)
        case photoAttachView.imageDeleteButton:
            photoAttachView.studentIDImage.image = .remove
            photoAttachView.studentIDImage.isHidden = true
            photoAttachView.imageDeleteButton.isHidden = true
            photoAttachView.nextButton.isEnabled = false
        default:
            break
        }
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

extension PhotoAttachViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            photoAttachView.studentIDImage.isHidden = false
            photoAttachView.imageDeleteButton.isHidden = false
            photoAttachView.studentIDImage.image = image
            photoAttachView.nextButton.isEnabled = true
            photoAttachView.bringSubviewToFront(photoAttachView.imageDeleteButton)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PhotoAttachViewController: UINavigationControllerDelegate {
    
}
