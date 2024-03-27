//
//  ReportCollectionViewCell.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 3/23/24.
//

import UIKit

import SnapKit

final class ReportCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    override var isSelected: Bool {
        didSet {
            updateReportUI()
        }
    }
    
    // MARK: - UI Components
    
    private let reportView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let reportTitle: UILabel = {
        let label = UILabel()
        label.font = .umbrellaFont(.body2)
        label.textColor = .gray500
        return label
    }()
    
    private let reportCheckView: UIView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray300
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    private let reportCheckImage = UIImageView(image: .icCheck)
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension ReportCollectionViewCell {

    func setUI() {
        backgroundColor = .clear
        reportCheckImage.isHidden = true
    }
    
    func setHierarchy() {
        reportCheckView.addSubview(reportCheckImage)
        reportView.addSubviews(reportTitle, reportCheckView)
        addSubview(reportView)
    }
    
    func setLayout() {
        reportView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        reportTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(15)
        }
        
        reportCheckView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
            $0.size.equalTo(24)
        }
        
        reportCheckImage.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(18)
        }
    }
    
    func updateReportUI() {
        reportView.backgroundColor = isSelected ? .lightBlue : .gray100
        reportTitle.textColor = isSelected ? .mainBlue : .gray500
        reportCheckView.backgroundColor = isSelected ? .mainBlue : .gray300
        reportCheckImage.isHidden = isSelected ? false : true
    }
}

extension ReportCollectionViewCell {

    func configureCell(model: ReportMenuDto) {
        reportTitle.text = model.title
    }
}
