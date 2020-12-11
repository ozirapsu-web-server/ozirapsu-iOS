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
    let stateLabel: UILabel = {
        let label = UILabel()
        let attributeText = NSAttributedString(string: CurHeaderText.openFund.rawValue,
                                               attributes: [.font: UIFont(name: FontName.notosans_bold,
                                                                          size: 18)!,
                                                            .kern: -0.72,
                                                            .foregroundColor: UIColor.black])
        label.attributedText = attributeText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontName.notosans_bold, size: 18)!
        label.textColor = .whowantsblue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1.0)
        uiView.clipsToBounds = true
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    let informLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        let attributeText = NSMutableAttributedString(string: CurHeaderText.inform.rawValue,
                                               attributes: [.font: UIFont(name: FontName.notosans_light,
                                                                          size: 12)!,
                                                            .kern: -0.48,
                                                            .foregroundColor: UIColor.mainblack])
        attributeText.addAttribute(.font, value: UIFont(name: FontName.notosans_medium, size: 12)!,
                                   range: (CurHeaderText.inform.rawValue as NSString).range(of: "TIP"))
        label.attributedText = attributeText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Data
    var isInit: Bool = true
    
    // MARK: - Action
    func setHeader(_ count: Int) {
        countLabel.text = "\(count)"
    }
    
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
        containerView.layer.cornerRadius = (bounds.width-20*2) / 83.74
        NSLayoutConstraint.activate([
            stateLabel.topAnchor.constraint(equalTo: topAnchor),
            stateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            countLabel.leadingAnchor.constraint(equalTo: stateLabel.trailingAnchor, constant: 4),
            containerView.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 14),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            informLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6),
            informLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            informLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            informLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -6)
        ])
    }
}
