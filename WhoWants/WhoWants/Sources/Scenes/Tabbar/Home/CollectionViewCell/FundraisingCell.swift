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

struct FundraisingCellDTO {
    let image: UIImage
    let title: String
    let count: Int
    let percent: Int
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
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let shareButton: UIButton = {
        let btn = UIButton(type: .system)
        let attributeText = NSAttributedString(string: FundraisingText.shareBtn.rawValue,
                                               attributes: [.font: UIFont(name: FontName.notosans_bold,
                                                                          size: 12)!,
                                                            .kern: -0.48,
                                                            .foregroundColor: UIColor.white])
        btn.backgroundColor = .whowantsblue
        btn.setAttributedTitle(attributeText, for: .normal)
        btn.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
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
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let percentLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Data
    var isInit: Bool = true
    
    // MARK: - Action
    func setFundraisingCell(_ dto: FundraisingCellDTO) {
        let titleAttributeText = NSAttributedString(string: dto.title,
                                                    attributes: [.font: UIFont(name: FontName.notosans_medium,
                                                                               size: 16)!,
                                                                 .kern: -0.64,
                                                                 .foregroundColor: UIColor.mainblack])
        titleLabel.attributedText = titleAttributeText
        
        let countText = dto.count.convertUnitKR() + "명이 서포팅 중"
        let countAttributeText = NSMutableAttributedString(string: countText,
                                                           attributes: [.font: UIFont(name: FontName.notosans_bold,
                                                                                      size: 12)!,
                                                                        .kern: -0.48,
                                                                        .foregroundColor: UIColor.mainblack])
        countAttributeText.addAttribute(.font, value: UIFont(name: FontName.notosans_regular, size: 12)!,
                                        range: (countText as NSString).range(of: "이 서포팅 중"))
        surportingCountLabel.attributedText = countAttributeText
        
        let percentAttributeText = NSAttributedString(string: "\(dto.percent)%",
                                                      attributes: [.font: UIFont(name: FontName.notosans_bold,
                                                                                 size: 14)!,
                                                                   .kern: -0.56,
                                                                   .foregroundColor: UIColor.whowantsblue])
        percentLabel.attributedText = percentAttributeText
    }
    
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
        shareButton.layer.cornerRadius = (bounds.width*0.21)/4.5
        thumbnailImageView.layer.cornerRadius = (bounds.width-20*2)/55.8
        let sharBtnTop = shareButton.topAnchor.constraint(greaterThanOrEqualTo: topContainerView.topAnchor)
        let shareBtnBottom = shareButton.bottomAnchor.constraint(greaterThanOrEqualTo: topContainerView.bottomAnchor)
        sharBtnTop.priority = UILayoutPriority(500)
        shareBtnBottom.priority = UILayoutPriority(500)
        
        let titleLabelTop = titleLabel.topAnchor.constraint(equalTo: topContainerView.topAnchor)
        let titleLabelBottom = titleLabel.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor)
        titleLabelTop.priority = UILayoutPriority(500)
        titleLabelBottom.priority = UILayoutPriority(500)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: bounds.width),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: bounds.width*0.6),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor,
                                                  constant: 9),
            contentStackView.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor),
            titleLabelTop,
            titleLabel.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -20),
            titleLabelBottom,
            sharBtnTop,
            shareBtnBottom,
            progressView.heightAnchor.constraint(equalToConstant: 6),
            shareButton.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor),
            shareButton.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor),
            shareButton.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.21),
            shareButton.heightAnchor.constraint(equalTo: shareButton.widthAnchor, multiplier: 0.41),
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
