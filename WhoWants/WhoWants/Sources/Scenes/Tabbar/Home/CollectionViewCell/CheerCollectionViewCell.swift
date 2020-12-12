//
//  CheerCollectionViewCell.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/12/12.
//

import UIKit

struct CheerCellDTO {
    let nickname: String
    let amount: Int
    let message: String
    let timestamp: String
}

class CheerCollectionViewCell: UICollectionViewCell {
    static let identifier = "CheerCell"
    
    // MARK: - UI
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageName.cheer_profile)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sirLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "님",
                                                  attributes: [.font: UIFont(name: FontName.notosans_regular,
                                                                             size: 12)!,
                                                               .foregroundColor: UIColor.mainblack])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let surportLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "후원",
                                                  attributes: [.font: UIFont(name: FontName.notosans_regular,
                                                                             size: 12)!,
                                                               .kern: -0.48,
                                                               .foregroundColor: UIColor.mainblack])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    private func initView() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(sirLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(surportLabel)
        contentView.addSubview(messageLabel)
        contentView.addSubview(timestampLabel)
    }
    
    func bind(_ dto: CheerCellDTO) {
        let nicknameAttributeText = NSAttributedString(string: dto.nickname,
                                                   attributes: [.font: UIFont(name: FontName.notosans_medium,
                                                                              size: 12)!,
                                                                .kern: -0.48,
                                                                .foregroundColor: UIColor.mainblack])
        nicknameLabel.attributedText = nicknameAttributeText
        
        let amountAttributeText = NSAttributedString(string: dto.amount.convertUnitKR() + "원",
                                                     attributes: [.font: UIFont(name: FontName.notosans_bold,
                                                                                size: 14)!,
                                                                  .kern: -0.56,
                                                                  .foregroundColor: UIColor.mainblack])
        amountLabel.attributedText = amountAttributeText
        
        let messageAttributeText = NSAttributedString(string: dto.message,
                                                      attributes: [.font: UIFont(name: FontName.notosans_light,
                                                                                 size: 12)!,
                                                                   .kern: -0.48,
                                                                   .foregroundColor: UIColor.mainblack])
        messageLabel.attributedText = messageAttributeText
        
        let timestampAttributeText = NSAttributedString(string: "1시간 전",
                                                        attributes: [.font: UIFont(name: FontName.notosans_light,
                                                                                   size: 10)!,
                                                                     .kern: -0.4,
                                                                     .foregroundColor: UIColor.mainblack])
        timestampLabel.attributedText = timestampAttributeText
    }
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.879,
                                                green: 0.879,
                                                blue: 0.879,
                                                alpha: 1.0).cgColor
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-20*2)
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
        let profileCorner: CGFloat = (UIScreen.main.bounds.width-20*2)*0.11/2
        profileImageView.layer.cornerRadius = profileCorner
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            profileImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.11),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            nicknameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            nicknameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor,
                                                   constant: 16),
            sirLabel.centerYAnchor.constraint(equalTo: nicknameLabel.centerYAnchor),
            sirLabel.leadingAnchor.constraint(equalTo: nicknameLabel.trailingAnchor, constant: 2),
            amountLabel.centerYAnchor.constraint(equalTo: nicknameLabel.centerYAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: sirLabel.trailingAnchor, constant: 5),
            surportLabel.centerYAnchor.constraint(equalTo: nicknameLabel.centerYAnchor),
            surportLabel.leadingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 8),
            messageLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 3),
            messageLabel.leadingAnchor.constraint(equalTo: nicknameLabel.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -41),
            timestampLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 6),
            timestampLabel.leadingAnchor.constraint(equalTo: nicknameLabel.leadingAnchor),
            timestampLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
