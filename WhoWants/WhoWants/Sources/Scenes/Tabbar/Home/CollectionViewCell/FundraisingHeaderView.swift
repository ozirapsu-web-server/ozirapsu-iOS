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

class FundraisingHeaderView: UICollectionReusableView {
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
        label.textColor = .mainblack
        label.font = UIFont.boldSystemFont(ofSize: 18)
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
        nameLabel.text = dto.name
        informLabel.text = dto.message
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
            profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            profileImageView.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: -20),
            labelStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor,
                                                    constant: 20),
            labelStackView.topAnchor.constraint(equalTo: profileImageView.topAnchor,
                                                constant: 3),
            labelStackView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor,
                                                   constant: -3),
            labelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: labelStackView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}
