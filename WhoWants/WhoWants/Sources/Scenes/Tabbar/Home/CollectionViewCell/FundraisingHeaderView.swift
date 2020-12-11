//
//  FundaisingHeaderView.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/12/04.
//

import UIKit

struct HeaderDataDTO {
    let name: String
    let message: String?
}

class FundraisingHeaderView: UICollectionReusableView, FundraiseHeaderAble {
    static let identifier = "FundraisingHeader"
    
    // MARK: - UI
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageName.profile)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 7
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let informLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainblack
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let lineView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    // MARK: - Data
    var isInit: Bool = true
    
    // MARK: - Init
    private func initView() {
        self.addSubview(profileImageView)
        self.addSubview(labelStackView)
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(informLabel)
        self.addSubview(lineView)
    }
    
    // MARK: - Action
    func setHeader(_ dto: HeaderDataDTO) {
        let nameText = dto.name + " 님"
        let nameAttributeText = NSMutableAttributedString(string: nameText,
                                                   attributes: [.font: UIFont(name: FontName.notosans_bold,
                                                                                                 size: 20)!,
                                                               .foregroundColor: UIColor.mainblack,
                                                               .kern: -0.72])
        nameAttributeText.addAttribute(.font, value: UIFont(name: FontName.notosans_regular,
                                                            size: 20)!, range: (nameText as NSString).range(of: "님"))
        
        nameLabel.attributedText = nameAttributeText
        
        let message = dto.message
        let messageAttributeText = NSAttributedString(string: message ?? "",
                                                      attributes: [.font: UIFont(name: FontName.notosans_regular,
                                                                                 size: 14)!,
                                                                   .foregroundColor: UIColor.mainblack,
                                                                   .kern: -0.56])
        informLabel.attributedText = messageAttributeText
    }
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func configureLayout() {
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.17),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            labelStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor,
                                                    constant: 20),
            labelStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            lineView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: labelStackView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}
