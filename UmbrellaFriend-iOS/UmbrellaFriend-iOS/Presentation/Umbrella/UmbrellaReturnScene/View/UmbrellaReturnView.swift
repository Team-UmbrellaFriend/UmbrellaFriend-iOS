//
//  UmbrellaReturnView.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/29/24.
//

import UIKit

import SnapKit
import AVFoundation

protocol UmbrellaReturnDelegate: AnyObject {
    func didExtractPlace(_ placeId: Int)
}

final class UmbrellaReturnView: UIView {
    
    // MARK: - Properties
    
    private var captureSession = AVCaptureSession()
    private var cameraDevice: AVCaptureDevice?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var isProcessingMetadata: Bool = false
    
    var delegate: UmbrellaReturnDelegate?
    var place: String = ""
    
    // MARK: - UI Components
    
    let exitButton: UIButton = {
        let button = UIButton()
        button.setImage(.icQrCancel, for: .normal)
        button.imageView?.tintColor = .umbrellaWhite
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "반납장소 QR코드 인식"
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
    
    let showPlaceButton: UIButton = {
        let button = UIButton()
        button.setTitle("QR 인식이 잘 안되시나요?", for: .normal)
        button.setTitleColor(.gray300, for: .normal)
        button.titleLabel?.font = .umbrellaFont(.body5)
        button.titleLabel?.setUnderlinePartFontChange(targetString: "QR 인식이 잘 안되시나요?", font: .umbrellaFont(.body5))
        button.backgroundColor = .clear
        return button
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private let qrView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.mainBlue.cgColor
        view.layer.borderWidth = 4
        return view
    }()
    
    let returnCameraAccessAlertView = CustomAlertView(type: .notice,
                                                        title: "카메라 사용 권한 없음",
                                                        subTitle: "설정 > {우산친구} 탭에서 접근을\n활성화 시킬 수 있습니다.")
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
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

private extension UmbrellaReturnView {
    
    func setUI() {
        returnCameraAccessAlertView.isHidden = true
        returnCameraAccessAlertView.alertCheckButton.setTitle("설정으로 이동", for: .normal)
    }
    
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
            }
        }
    }
    
    func initCameraOutputData() {
        let captureMetadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(captureMetadataOutput) { captureSession.addOutput(captureMetadataOutput)
            if captureMetadataOutput.availableMetadataObjectTypes.contains(AVMetadataObject.ObjectType.qr) {
                captureMetadataOutput.metadataObjectTypes = [.qr]
            } else {
                print("QR 코드가 지원되지 않는 디바이스입니다.")
                returnCameraAccessAlertView.isHidden = false
            }
        }
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    }
    
    func displayPreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        DispatchQueue.main.async {
            self.videoPreviewLayer?.frame = CGRect(x: 0.0, y: 0.0, width: SizeLiterals.Screen.screenWidth, height: SizeLiterals.Screen.screenHeight)
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }
    
    func setHierarchy() {
        if let videoPreviewLayer = self.videoPreviewLayer {
            self.layer.addSublayer(videoPreviewLayer)
        }
        addSubview(backgroundView)
        backgroundView.addSubview(qrView)
        addSubviews(exitButton, titleLabel, subTitleLabel, showPlaceButton, returnCameraAccessAlertView)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        qrView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(180)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(SizeLiterals.Screen.deviceRatio > 0.5 ? 230 : SizeLiterals.Screen.screenWidth * 259 / 375)
        }
        
        exitButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(4)
            $0.leading.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(112)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        showPlaceButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-SizeLiterals.Screen.screenHeight * 255 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(188)
            $0.height.equalTo(24)
        }
        
        returnCameraAccessAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension UmbrellaReturnView: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard !isProcessingMetadata else { return }
        
        if metadataObjects.count == 0 { return }
        
        guard let metaDataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else {
            return
        }
        
        if metaDataObj.type == .qr {
            guard let qrCodeStringData = metaDataObj.stringValue else { return }
            let urlParts = qrCodeStringData.split(separator: "/")
            switch String(urlParts[4]) {
            case "myungshin":
                delegate?.didExtractPlace(1)
            case "renaissance":
                delegate?.didExtractPlace(2)
            case "science":
                delegate?.didExtractPlace(3)
            case "art":
                delegate?.didExtractPlace(4)
            default:
                break
            }
            makeVibrate()
            isProcessingMetadata = true
        }
    }
}
