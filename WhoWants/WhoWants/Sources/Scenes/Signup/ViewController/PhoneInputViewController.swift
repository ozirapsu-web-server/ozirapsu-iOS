//
//  PhoneInputViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/28.
//

import UIKit

enum PhoneInputText: String {
    case title = "휴대폰 번호를\n입력해주세요"
    case phonePlaceholder = "'-'을 제외하고 입력해주세요"
}

class PhoneInputViewController: UIViewController {
    // MARK: - UI
    var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .mainblack
        label.numberOfLines = 0
        label.text = PhoneInputText.title.rawValue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var phoneMarginView: UIView = {
        var uiView = UIView()
        uiView.backgroundColor = .clear
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    var phoneTextfield: UITextField = {
        var textField = UITextField()
        textField.borderStyle = .none
        textField.keyboardType = .numberPad
        let attributeText = NSAttributedString(string: PhoneInputText.phonePlaceholder.rawValue,
                                               attributes: [.font: UIFont.systemFont(ofSize: 14)])
        textField.attributedPlaceholder = attributeText
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var lineView: UIView = {
        var uiView = UIView()
        uiView.backgroundColor = .lightGray
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    var completeButton: UIButton = {
        var btn = UIButton(type: .system)
        btn.backgroundColor = .graytext
        btn.setTitle(EmailInputText.next.rawValue, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.clipsToBounds = true
        btn.isUserInteractionEnabled = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - Action
    var completion: ((String) -> Void)?
    
    // MARK: - Init
    private func initView() {
        view.addSubview(titleLabel)
        view.addSubview(phoneMarginView)
        phoneMarginView.addSubview(phoneTextfield)
        phoneMarginView.addSubview(lineView)
        view.addSubview(completeButton)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        configureLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCornerRadius()
    }
    
    // MARK: - Layout
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 31),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneMarginView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            phoneMarginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneMarginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneTextfield.topAnchor.constraint(equalTo: phoneMarginView.topAnchor),
            phoneTextfield.leadingAnchor.constraint(equalTo: phoneMarginView.leadingAnchor),
            phoneTextfield.trailingAnchor.constraint(equalTo: phoneMarginView.trailingAnchor),
            lineView.topAnchor.constraint(equalTo: phoneTextfield.bottomAnchor, constant: 4),
            lineView.leadingAnchor.constraint(equalTo: phoneMarginView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: phoneMarginView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.bottomAnchor.constraint(equalTo: phoneMarginView.bottomAnchor),
            completeButton.topAnchor.constraint(equalTo: phoneMarginView.bottomAnchor, constant: 139),
            completeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            completeButton.heightAnchor.constraint(equalTo: completeButton.widthAnchor, multiplier: 0.14)
        ])
    }
    
    private func configureCornerRadius() {
        let corner: CGFloat = (UIScreen.main.bounds.width - 20*2) / 83.75
        completeButton.layer.cornerRadius = corner
    }
}

extension PhoneInputViewController: SignupInputable {
    var type: SignupInputType {
        return .phone
    }
    
    var transfer: ((String) -> Void)? {
        get {
            return completion
        }
        set {
            completion = newValue
        }
    }
}
