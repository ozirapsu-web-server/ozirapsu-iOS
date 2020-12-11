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
        let attributeText = NSAttributedString(string: EmailInputText.next.rawValue,
                                               attributes: [.font: UIFont(name: FontName.notosans_medium,
                                                                          size: 16)!,
                                                            .kern: -0.64,
                                                            .foregroundColor: UIColor.white])
        btn.setAttributedTitle(attributeText, for: .normal)
        btn.backgroundColor = .graytext
        btn.clipsToBounds = true
        btn.isUserInteractionEnabled = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var titleLabel: UILabel = {
        var label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.97
        label.attributedText = NSAttributedString(string: EmailInputText.title.rawValue,
                                                  attributes: [.font: UIFont(name: FontName.notosans_bold,
                                                                             size: 18)!,
                                                               .kern: -0.72,
                                                               .paragraphStyle: paragraphStyle,
                                                               .foregroundColor: UIColor.mainblack])
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
                                               attributes: [.font: UIFont(name: FontName.notosans_regular,
                                                                          size: 14)!,
                                                            .kern: -0.56])
        textField.textColor = .mainblack
        textField.attributedPlaceholder = attributeText
        textField.attributedText = attributeText
        textField.text = ""
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
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        let attributeText = NSAttributedString(string: EmailInputText.invalid.rawValue,
                                               attributes: [.font: UIFont(name: FontName.notosans_regular,
                                                                          size: 12)!,
                                                            .kern: -0.48,
                                                            .paragraphStyle: paragraphStyle,
                                                            .foregroundColor: UIColor(red: 0.979,
                                                                                      green: 0.224,
                                                                                      blue: 0.224,
                                                                                      alpha: 1.0)])
        label.attributedText = attributeText
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Action
    var completion: ((String) -> Void)?
    
    @objc
    func complete(_ sender: UIButton) {
        completion?(emailTextField.text!)
    }
    
    @objc
    func deleteText(_ sender: UIButton) {
        emailTextField.text?.removeAll()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCornerRadius()
    }
    
    deinit {
        print("Email DeInitialize")
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
            completeButton.backgroundColor = .graytext
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
