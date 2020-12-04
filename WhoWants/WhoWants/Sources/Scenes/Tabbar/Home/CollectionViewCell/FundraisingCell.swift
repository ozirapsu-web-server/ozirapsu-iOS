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
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 7
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
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .whowantsblue
        btn.setAttributedTitle(NSAttributedString(string: FundraisingText.shareBtn.rawValue,
                                                  attributes: [.font: UIFont.boldSystemFont(ofSize: 18),
                                                               .foregroundColor: UIColor.white]),
                               for: .normal)
        return btn
    }()
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.setProgress(0.5, animated: false)
        progressView.progressTintColor = .whowantsblue
        return progressView
    }()
    
    let bottomContainerView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        return uiView
    }()
    
    let surporterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageName.profile)
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
    
    // MARK: - Init
    private func initView() {
        self.contentView.addSubview(thumbnailImageView)
        self.contentView.addSubview(contentStackView)
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
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor,
                                                       multiplier: 0.58),
            contentStackView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor,
                                                  constant: 10),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            shareButton.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor),
            shareButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            shareButton.widthAnchor.constraint(equalTo: topContainerView.widthAnchor,
                                               multiplier: 0.21),
            shareButton.heightAnchor.constraint(equalTo: shareButton.widthAnchor, multiplier: 0.3),
            titleLabel.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topContainerView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            surporterImageView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor),
            surporterImageView.topAnchor.constraint(equalTo: surportingCountLabel.topAnchor),
            surporterImageView.bottomAnchor.constraint(equalTo: surportingCountLabel.bottomAnchor),
            surportingCountLabel.leadingAnchor.constraint(equalTo: surporterImageView.trailingAnchor,
                                                          constant: 2),
            surportingCountLabel.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor),
            percentLabel.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor),
            percentLabel.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor),
            percentLabel.topAnchor.constraint(equalTo: bottomContainerView.topAnchor)
        ])
    }
}
