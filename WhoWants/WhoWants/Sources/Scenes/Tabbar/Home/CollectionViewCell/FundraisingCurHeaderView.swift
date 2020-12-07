//
//  FundraisingCurHeaderView.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/12/05.
//

import UIKit

enum CurHeaderText: String {
    case openFund = "개설한 모금함"
    case inform = "🍯TIP 개설한 모금함을 공유하시면 200%나 더 빨리 목표에 달성할 수 있습니다."
}

class FundraisingCurHeaderView: UICollectionReusableView, FundraiseHeaderAble {
    static let identifier = "FundraisingCurHeaderView"
    
    // MARK: - UI
    var stateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = CurHeaderText.openFund.rawValue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .whowantsblue
        // FIXME: 데이터에 따라 변화하게 변경
        label.text = "2"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var containerView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        uiView.clipsToBounds = true
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    var informLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = CurHeaderText.inform.rawValue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .mainblack
        return label
    }()
    
    // MARK: - Data
    var isInit: Bool = true
    
    // MARK: - Init
    private func initView() {
        self.addSubview(stateLabel)
        self.addSubview(countLabel)
        self.addSubview(containerView)
        containerView.addSubview(informLabel)
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
        containerView.layer.cornerRadius = (bounds.width-20*2) / 25
        NSLayoutConstraint.activate([
            stateLabel.topAnchor.constraint(equalTo: topAnchor),
            stateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            countLabel.leadingAnchor.constraint(equalTo: stateLabel.trailingAnchor, constant: 4),
            containerView.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 14),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            informLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            informLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            informLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            informLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15)
        ])
    }
}
