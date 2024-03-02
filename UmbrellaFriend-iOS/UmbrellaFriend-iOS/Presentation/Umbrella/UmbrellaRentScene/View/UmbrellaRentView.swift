//
//  UmbrellaRentView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/11/24.
//

import UIKit

import SnapKit
import AVFoundation

protocol UmbrellaRentDelegate: AnyObject {
    func didExtractNumber(_ number: String)
}

final class UmbrellaRentView: UIView {
    
    // MARK: - Properties
    
    private var captureSession = AVCaptureSession()
    private var cameraDevice: AVCaptureDevice?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var isProcessingMetadata: Bool = false
    
    var delegate: UmbrellaRentDelegate?
    var number: String = ""
    
    // MARK: - UI Components
    
    let exitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.imageView?.tintColor = .black
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "우산 QR코드 인식"
        label.textColor = .umbrellaWhite
        label.textAlignment = .center
        label.font = .umbrellaFont(.title1)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "QR을 사각형에 맞춰 스캔해주세요"
        label.textColor = .umbrellaWhite
        label.textAlignment = .center
        label.font = .umbrellaFont(.body3)
        return label
    }()
    
    let mapButton: UIButton = {
        let button = UIButton()
        button.setTitle("우산위치를 검색하고 싶으신가요?", for: .normal)
        button.setTitleColor(.gray300, for: .normal)
        button.titleLabel?.font = .umbrellaFont(.body5)
        button.titleLabel?.setUnderlinePartFontChange(targetString: "우산위치를 검색하고 싶으신가요?", font: .umbrellaFont(.body5))
        button.backgroundColor = .clear
        return button
    }()
    
    private let backgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.umbrellaBlack.withAlphaComponent(0.6)
        return view
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initCameraDevice()
        initCameraInputData()
        initCameraOutputData()
        displayPreview()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension UmbrellaRentView {
    
    func initCameraDevice() {
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Failed to get the camera device")
            return
        }
        cameraDevice = captureDevice
    }
    
    func initCameraInputData() {
        if let cameraDevice = self.cameraDevice {
            do {
                let input = try AVCaptureDeviceInput(device: cameraDevice)
                if captureSession.canAddInput(input) { captureSession.addInput(input) }
            } catch {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func initCameraOutputData() {
        let captureMetadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(captureMetadataOutput) { captureSession.addOutput(captureMetadataOutput) }
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
    }
    
    func displayPreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        DispatchQueue.main.async {
            let viewSize: CGFloat = SizeLiterals.Screen.screenWidth * 250 / 375
            let xOrigin = (SizeLiterals.Screen.screenWidth - viewSize) / 2
            let yOrigin = self.safeAreaInsets.top + 176
            print(yOrigin)
            self.videoPreviewLayer?.frame = CGRect(x: xOrigin, y: yOrigin, width: viewSize, height: viewSize)
            self.layer.addSublayer(self.videoPreviewLayer!)
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }
    
    func setHierarchy() {
        addSubviews(backgroundView, exitButton, titleLabel, subTitleLabel, mapButton)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        exitButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(5)
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(102)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        mapButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-SizeLiterals.Screen.screenHeight * 260 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(188)
            $0.height.equalTo(24)
        }
    }
}

extension UmbrellaRentView: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard !isProcessingMetadata else { return }
        
        if metadataObjects.count == 0 { return }
        
        guard let metaDataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else {
            return
        }
        
        if metaDataObj.type == .qr {
            guard let qrCodeStringData = metaDataObj.stringValue else { return }
            if let numberRange = qrCodeStringData.range(of: "/(\\d+)/", options: .regularExpression) {
                let number = qrCodeStringData[numberRange].replacingOccurrences(of: "/", with: "")
                delegate?.didExtractNumber(number)
                self.number = number
                isProcessingMetadata = true
            }
        }
    }
}
