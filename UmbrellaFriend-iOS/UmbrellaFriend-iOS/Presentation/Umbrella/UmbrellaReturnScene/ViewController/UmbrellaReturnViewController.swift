//
//  UmbrellaReturnViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

import VisionKit
import Vision

final class UmbrellaReturnViewController: UIViewController {
    
    // MARK: - Properties
    
    private var photoPlaceNum: Int = 0
    private let returnViewModel = UmbrellaReturnViewModel()
    
    // MARK: - UI Components
    
    private let umbrellaReturnView = UmbrellaReturnView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = umbrellaReturnView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setAddTarget()
    }
}

// MARK: - Extensions

extension UmbrellaReturnViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func setDelegate() {
        umbrellaReturnView.navigationView.delegate = self
        umbrellaReturnView.returnButton.delegate = self
        umbrellaReturnView.returnAlertView.delegate = self
    }
    
    func setAddTarget() {
        umbrellaReturnView.registerButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        umbrellaReturnView.imageDeleteButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        umbrellaReturnView.navigationView.againButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc
    func tapButton(_ sender: UIButton) {
        switch sender {
        case umbrellaReturnView.registerButton, umbrellaReturnView.navigationView.againButton:
            let cameraVC = UIImagePickerController()
            cameraVC.sourceType = .camera
            cameraVC.delegate = self
            self.present(cameraVC, animated: true, completion: nil)
        case umbrellaReturnView.imageDeleteButton:
            self.photoPlaceNum = 0
            umbrellaReturnView.returnImage.image = .remove
            umbrellaReturnView.returnImage.isHidden = true
            umbrellaReturnView.imageDeleteButton.isHidden = true
            umbrellaReturnView.returnTitleLabel.text = "반납 완료를 위해\n카메라로 인증해주세요"
            umbrellaReturnView.returnSubTitleLabel.isHidden = false
            umbrellaReturnView.returnButton.isEnabled = false
            umbrellaReturnView.navigationView.isAgainButtonInclued = false
        default:
            break
        }
    }
    
    func extractPlaceInfo(image: UIImage?){
        guard let cgImage = image?.cgImage else { return }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest{ [weak self]request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else{ return }
            
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { continue }
                let recognizedText = topCandidate.string
                
                if recognizedText.contains("명신관") {
                    self?.photoPlaceNum = 1
                    self?.returnViewModel.umbrellaReturnLocation(location: "명신관")
                } else if recognizedText.contains("순헌관") {
                    self?.photoPlaceNum = 2
                    self?.returnViewModel.umbrellaReturnLocation(location: "순헌관")
                } else if recognizedText.contains("도서관") {
                    self?.photoPlaceNum = 3
                    self?.returnViewModel.umbrellaReturnLocation(location: "도서관")
                } else if recognizedText.contains("학생회관") {
                    self?.photoPlaceNum = 4
                    self?.returnViewModel.umbrellaReturnLocation(location: "학생회관")
                } else if recognizedText.contains("음대") {
                    self?.photoPlaceNum = 5
                    self?.returnViewModel.umbrellaReturnLocation(location: "음대")
                } else if recognizedText.contains("백주년기념관") {
                    self?.photoPlaceNum = 6
                    self?.returnViewModel.umbrellaReturnLocation(location: "백주년기념관")
                }
            }
        }
        
        if #available(iOS 16.0, *) {
            let revision3 = VNRecognizeTextRequestRevision3
            request.revision = revision3
            request.recognitionLevel = .accurate
            request.recognitionLanguages = ["ko-KR"]
            request.usesLanguageCorrection = true
            
            do {
                var possibleLanguages: Array<String> = []
                possibleLanguages = try request.supportedRecognitionLanguages()
                print(possibleLanguages)
            } catch {
                print("Error getting the supported languages.")
            }
        } else {
            request.recognitionLanguages = ["ko-KR"]
            request.usesLanguageCorrection = true
        }
        
        do{
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}

extension UmbrellaReturnViewController: NavigationBarProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension UmbrellaReturnViewController: ButtonProtocol {
    
    func buttonTapped() {
        let nav = UmbrellaReturnBottomSheetViewController(viewModel: self.returnViewModel)
        if photoPlaceNum == 0 {
            self.umbrellaReturnView.returnAlertView.isHidden = false
        } else {
            nav.returnPhotoPlace = self.photoPlaceNum
            nav.modalPresentationStyle = .overFullScreen
            self.present(nav, animated: false)
        }
    }
}

extension UmbrellaReturnViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.extractPlaceInfo(image: image)
            if let imageData = image.jpegData(compressionQuality: 0.5) {
                returnViewModel.umbrellaReturnImage(img: imageData)
            }
            umbrellaReturnView.returnImage.isHidden = false
            umbrellaReturnView.imageDeleteButton.isHidden = false
            umbrellaReturnView.returnImage.image = image
            umbrellaReturnView.returnButton.isEnabled = true
            umbrellaReturnView.returnTitleLabel.text = "우산반납을\n인증하실건가요?"
            umbrellaReturnView.returnSubTitleLabel.isHidden = true
            umbrellaReturnView.navigationView.isAgainButtonInclued = true
            umbrellaReturnView.bringSubviewToFront(umbrellaReturnView.imageDeleteButton)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UmbrellaReturnViewController: UINavigationControllerDelegate {
    
}

extension UmbrellaReturnViewController: CustomAlertButtonDelegate {
    
    func tapCheckButton() {
        umbrellaReturnView.returnAlertView.isHidden = true
        umbrellaReturnView.returnImage.image = .remove
        umbrellaReturnView.returnImage.isHidden = true
        umbrellaReturnView.imageDeleteButton.isHidden = true
        umbrellaReturnView.returnTitleLabel.text = "반납 완료를 위해\n카메라로 인증해주세요"
        umbrellaReturnView.returnSubTitleLabel.isHidden = false
        umbrellaReturnView.returnButton.isEnabled = false
        umbrellaReturnView.navigationView.isAgainButtonInclued = false
    }
}
