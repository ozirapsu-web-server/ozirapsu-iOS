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
    case invalid = "유효하지 않은 이메일입니다."
}

class EmailInputViewController: UIViewController {
    // MARK: - UI
    var completeButton: UIButton = {
        var btn = UIButton(type: .system)
        btn.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
        btn.clipsToBounds = true
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.isUserInteractionEnabled = false
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
    
    var cancelButton: UIButton = {
        var btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: ImageName.cancelBtn), for: .normal)
        btn.tintColor = .mainblack
        btn.isHidden = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var lineView: UIView = {
        var uiView = UIView()
        uiView.backgroundColor = .lightGray
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    var invalidLabel: UILabel = {
        var label = UILabel()
        label.textColor = .red
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = EmailInputText.invalid.rawValue
        return label
    }()
    
    // MARK: - Action
    var completion: ((String) -> Void)?
    
    @objc
    func complete(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.transform = CGAffineTransform(translationX: -50, y: 0)
            self.view.alpha = 0
        }, completion: { isCompletion in
            self.completion?(self.emailTextField.text!)
        })
    }
    
    @objc
    func deleteText(_ sender: UIButton) {
        emailTextField.text?.removeAll()
    }
    
    private func appearAnimate() {
        self.view.alpha = 0
        self.view.transform = CGAffineTransform(translationX: 50, y: 0)
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 1
            self.view.transform = .identity
        })
    }
    
    // MARK: - Init
    private func initView() {
        view.addSubview(titleLabel)
        view.addSubview(textMarginView)
        textMarginView.addSubview(emailTextField)
        textMarginView.addSubview(lineView)
        view.addSubview(cancelButton)
        view.addSubview(invalidLabel)
        view.addSubview(completeButton)
    }
    
    private func setDelegate() {
        emailTextField.delegate = self
    }
    
    private func setButtonAction() {
        completeButton.addTarget(self, action: #selector(complete(_:)), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(deleteText(_:)), for: .touchUpInside)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        initView()
        setDelegate()
        setButtonAction()
        
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        appearAnimate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCornerRadius()
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
            cancelButton.centerYAnchor.constraint(equalTo: textMarginView.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),
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
                                                   multiplier: 0.14),
            invalidLabel.topAnchor.constraint(equalTo: textMarginView.bottomAnchor, constant: 8),
            invalidLabel.leadingAnchor.constraint(equalTo: textMarginView.leadingAnchor)
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

extension EmailInputViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text == "" { cancelButton.isHidden = true }
        else { cancelButton.isHidden = false }
        if !text.isEmailFormat() {
            completeButton.isUserInteractionEnabled = false
            completeButton.backgroundColor = UIColor(red: 170/255,
                                                     green: 170/255,
                                                     blue: 170/255,
                                                     alpha: 1.0)
            if text == "" {
                lineView.backgroundColor = .mainblack
                invalidLabel.isHidden = true
            } else {
                lineView.backgroundColor = .red
                invalidLabel.isHidden = false
            }
        } else {
            lineView.backgroundColor = .mainblack
            invalidLabel.isHidden = true
            completeButton.isUserInteractionEnabled = true
            completeButton.backgroundColor = .mainblack
        }
    }
}
