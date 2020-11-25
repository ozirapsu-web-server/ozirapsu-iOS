//
//  EmailInputViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/25.
//

import UIKit

enum EmailInputText: String {
    case title = "로그인에 사용할\n이메일을 입력해주세요"
    case next = "다음"
    case textFieldPlaceholder = "이메일 주소를 입력해주세요"
}

class EmailInputViewController: UIViewController {
    // MARK: - UI
    var completeButton: UIButton = {
        var btn = UIButton(type: .system)
        btn.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
        btn.clipsToBounds = true
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle(EmailInputText.next.rawValue, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .mainblack
        label.text = EmailInputText.title.rawValue
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var textMarginView: UIView = {
        var uiView = UIView()
        uiView.backgroundColor = .clear
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    var emailTextField: UITextField = {
        var textField = UITextField()
        textField.borderStyle = .none
        let attributeText = NSAttributedString(string: EmailInputText.textFieldPlaceholder.rawValue,
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
    
    // MARK: - Action
    var completion: ((String) -> Void)?
    
    @objc
    func complete(_ sender: UIButton) {
        completion?("Hi")
    }
    
    // MARK: - Init
    private func initView() {
        view.addSubview(titleLabel)
        view.addSubview(textMarginView)
        textMarginView.addSubview(emailTextField)
        textMarginView.addSubview(lineView)
        view.addSubview(completeButton)
    }
    
    @objc
    func setButtonAction() {
        completeButton.addTarget(self, action: #selector(complete(_:)), for: .touchUpInside)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        initView()
        configureLayout()
        configureCornerRadius()
        setButtonAction()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    deinit {
        print("DeInitialize")
    }
    
    // MARK: - Layout
    private func configureLayout() {
        let textMarginViewTrailing = textMarginView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                constant: -20)
        textMarginViewTrailing.priority = UILayoutPriority(750)
        
        let completeBtnTrailing = completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                           constant: -20)
        completeBtnTrailing.priority = UILayoutPriority(750)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: 31),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textMarginView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                constant: 40),
            textMarginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textMarginViewTrailing,
            emailTextField.topAnchor.constraint(equalTo: textMarginView.topAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: textMarginView.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: textMarginView.trailingAnchor),
            lineView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 4),
            lineView.leadingAnchor.constraint(equalTo: textMarginView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: textMarginView.trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: textMarginView.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            completeButton.topAnchor.constraint(equalTo: textMarginView.bottomAnchor,
                                                constant: 60),
            completeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            completeBtnTrailing,
            completeButton.heightAnchor.constraint(equalTo: completeButton.widthAnchor,
                                                   multiplier: 0.14)
        ])
    }
    
    private func configureCornerRadius() {
        let corner: CGFloat = (UIScreen.main.bounds.width - 20*2) / 83.75
        completeButton.layer.cornerRadius = corner
    }
}

extension EmailInputViewController: SignupInputable {
    var type: SignupInputType {
        return .email
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
