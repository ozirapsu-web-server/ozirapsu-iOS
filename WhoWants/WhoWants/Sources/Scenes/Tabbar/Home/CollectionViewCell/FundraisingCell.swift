//
//  FundraisingCell.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/12/04.
//

import UIKit

enum FundraisingText: String {
    case shareBtn = "공유하기"
}

class FundraisingCell: UICollectionViewCell {
    static let identifier = "FundaisingCell"
    
    // MARK: - UI
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sample")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 9
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let topContainerView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        return uiView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .mainblack
        label.text = "후원츠를 도와주세요!"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let shareButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .whowantsblue
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle(FundraisingText.shareBtn.rawValue, for: .normal)
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.setProgress(0.5, animated: false)
        progressView.progressTintColor = .whowantsblue
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    let bottomContainerView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        return uiView
    }()
    
    let surporterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: ImageName.surporter)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let surportingCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .mainblack
        label.text = "2000명이 서포팅 중"
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let percentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .whowantsblue
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.text = "80%"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Data
    var isInit: Bool = true 
    
    // MARK: - Init
    private func initView() {
        self.addSubview(thumbnailImageView)
        self.addSubview(contentStackView)
        contentStackView.addArrangedSubview(topContainerView)
        topContainerView.addSubview(titleLabel)
        topContainerView.addSubview(shareButton)
        contentStackView.addArrangedSubview(progressView)
        contentStackView.addArrangedSubview(bottomContainerView)
        bottomContainerView.addSubview(surporterImageView)
        bottomContainerView.addSubview(surportingCountLabel)
        bottomContainerView.addSubview(percentLabel)
    }
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        initView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Layout
    private func configureLayout() {
        shareButton.layer.cornerRadius = (bounds.width*0.5) / 10
        thumbnailImageView.layer.cornerRadius = (bounds.width*0.6) / 20
        let sharBtnTop = shareButton.topAnchor.constraint(greaterThanOrEqualTo: topContainerView.topAnchor,
                                                          constant: 4)
        let shareBtnBottom = shareButton.bottomAnchor.constraint(greaterThanOrEqualTo: topContainerView.bottomAnchor, constant: -4)
        sharBtnTop.priority = UILayoutPriority(1000)
        shareBtnBottom.priority = UILayoutPriority(1000)
        
        let titleLabelTop = titleLabel.topAnchor.constraint(equalTo: topContainerView.topAnchor,
                                                            constant: 4)
        let titleLabelBottom = titleLabel.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor,
                                                                  constant: -4)
        titleLabelTop.priority = UILayoutPriority(750)
        titleLabelBottom.priority = UILayoutPriority(750)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: bounds.width),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: bounds.width*0.6),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor,
                                                  constant: 10),
            contentStackView.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor),
            titleLabelTop,
            titleLabel.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -20),
            titleLabelBottom,
            sharBtnTop,
            shareBtnBottom,
            progressView.heightAnchor.constraint(equalToConstant: 7),
            shareButton.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor),
            shareButton.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor),
            shareButton.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.29),
            shareButton.heightAnchor.constraint(equalTo: shareButton.widthAnchor, multiplier: 0.38),
            percentLabel.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor),
            percentLabel.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor),
            bottomContainerView.heightAnchor.constraint(equalTo: percentLabel.heightAnchor),
            percentLabel.topAnchor.constraint(equalTo: bottomContainerView.topAnchor),
            surportingCountLabel.leadingAnchor.constraint(equalTo: surporterImageView.trailingAnchor,
                                                          constant: 4),
            surportingCountLabel.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor),
            surporterImageView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor),
            surporterImageView.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor)
        ])
    }
}

extension FundraisingCell: FundraiseCellAble {
    
}
