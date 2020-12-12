//
//  FundraisingImageCell.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/12/12.
//

import UIKit

class FundraisingImageCell: UICollectionViewCell {
    static let identifier = "FundraisingImageCell"
    
    // MARK: - UI
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "sample")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Init
    private func initView() {
        self.contentView.addSubview(imageView)
    }
    
    // MARK: - Action
    func bind() {
        
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Layout
    private func configureLayout() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
