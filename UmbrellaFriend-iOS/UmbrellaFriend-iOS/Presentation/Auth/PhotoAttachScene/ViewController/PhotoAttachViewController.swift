//
//  PhotoAttachViewController.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/17/24.
//

import UIKit

import VisionKit
import Vision

final class PhotoAttachViewController: UIViewController {
    
    // MARK: - Properties
    
    var fromLoginView: Bool = true
    var photoName: String = ""
    var photoId: String = ""
    
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
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.photoAttachView.registerTitleLabel.text = self.fromLoginView ? "학생증을\n등록해 인증해주세요." : "반납 완료를 위해\n카메라로 인증해주세요"
        self.photoAttachView.registerSubTitleLabel.text = self.fromLoginView ? "학번과 이름이 보이게 첨부해주세요" : "네임택과 반납 장소가 보이게 찍어주세요"
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
    
    func extractSevenDigitNumbers(from text: String) -> String {
        let pattern = "\\b\\d{7}\\b"
        
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            
            let sevenDigitNumbers = matches.map {
                String(text[Range($0.range, in: text)!])
            }.joined(separator: "\n")
            
            return sevenDigitNumbers
        } catch {
            print("Error creating regular expression: \(error)")
            return ""
        }
    }
    
    func extractInfo(image: UIImage?){
        guard let cgImage = image?.cgImage else { return }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest{ [weak self]request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else{ return }
            
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: "\n")
            
            for observation in observations {
                if let topCandidate = observation.topCandidates(1).first,
                   let range = topCandidate.string.range(of: "\\b\\d{7}\\b", options: .regularExpression) {
                    if let line = observation.topCandidates(1).first?.string.components(separatedBy: "\n").first,
                       range.lowerBound >= line.startIndex && range.upperBound <= line.endIndex {
                        let koreanPattern = "[가-힣]+"
                        if let koreanRange = line.range(of: koreanPattern, options: .regularExpression) {
                            let koreanText = String(line[koreanRange])
                            self?.photoName = koreanText
                        }
                    }
                }
            }
            
            let sevenDigitNumbers = self?.extractSevenDigitNumbers(from: text)
            self?.photoId = sevenDigitNumbers ?? ""
        }
        
        if #available(iOS 16.0, *) {
            let revision3 = VNRecognizeTextRequestRevision3
            request.revision = revision3
            request.recognitionLevel = .accurate
            request.recognitionLanguages = ["ko-KR"]
            request.usesLanguageCorrection = true
            
            do {
                _ = try request.supportedRecognitionLanguages()
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

extension PhotoAttachViewController: NavigationBarProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PhotoAttachViewController: ButtonProtocol {
    
    func buttonTapped() {
        let nav = SignupViewController()
        nav.extractName = self.photoName
        nav.extractId = self.photoId
        self.navigationController?.pushViewController(nav, animated: true)
    }
}

extension PhotoAttachViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.extractInfo(image: image)
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
