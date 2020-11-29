//
//  SigninViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/25.
//

import UIKit

enum SigninText: String {
    case title = "모금함 개설하기\n후원츠와 함께 시작해보세요"
    case subTitle = "후원츠와 함께 더 나은 세상을 만들어보세요"
    case signinBtn = "로그인"
    case signupBtn = "아직 회원이 아니신가요?"
    case emailPlaceholder = "이메일 주소를 입력해주세요"
    case pwPlaceholder = "비밀번호를 입력해주세요"
}

class SigninViewController: UIViewController {
    // MARK: - UI
    var titleLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.text = SigninText.title.rawValue
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var subLabel: UILabel = {
        var label = UILabel()
        label.text = SigninText.subTitle.rawValue
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var textFieldStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var emailMarginView: UIView = {
        var uiView = UIView()
        uiView.backgroundColor = .clear
        return uiView
    }()
    
    var emailTextField: UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1.0)
        textField.borderStyle = .none
        let attributeText = NSAttributedString(string: SigninText.emailPlaceholder.rawValue,
                                               attributes: [.foregroundColor: UIColor.white,
                                                            .font: UIFont.systemFont(ofSize: 14)])
        textField.attributedPlaceholder = attributeText
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var emailLineView: UIView = {
        var uiView = UIView()
        uiView.backgroundColor = .white
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    var pwMarginView: UIView = {
        var uiView = UIView()
        uiView.backgroundColor = .clear
        return uiView
    }()
    
    var pwTextField: UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1.0)
        textField.borderStyle = .none
        let attributeText = NSAttributedString(string: SigninText.pwPlaceholder.rawValue,
                                               attributes: [.foregroundColor: UIColor.white,
                                                            .font: UIFont.systemFont(ofSize: 14)])
        textField.attributedPlaceholder = attributeText
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var pwLineView: UIView = {
        var uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.backgroundColor = .white
        return uiView
    }()
    
    var buttonStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var loginButton: UIButton = {
        var btn = UIButton(type: .system)
        btn.backgroundColor = .whowantsblue
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        let attributeText = NSAttributedString(string: SigninText.signinBtn.rawValue,
                                               attributes: [.kern: -0.64,
                                                            .font: UIFont.boldSystemFont(ofSize: 16),
                                                            .foregroundColor: UIColor.white])
        btn.setAttributedTitle(attributeText, for: .normal)
        return btn
    }()
    
    var signupButton: UIButton = {
        var btn = UIButton(type: .system)
        btn.backgroundColor = .clear
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        let attributeText = NSAttributedString(string: SigninText.signupBtn.rawValue,
                                               attributes: [.kern: -0.64,
                                                            .font: UIFont.boldSystemFont(ofSize: 16),
                                                            .foregroundColor: UIColor.white])
        btn.setAttributedTitle(attributeText, for: .normal)
        return btn
    }()
    
    // MARK: - Init
    private func initView() {
        view.addSubview(titleLabel)
        view.addSubview(subLabel)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(loginButton)
        buttonStackView.addArrangedSubview(signupButton)
        view.addSubview(textFieldStackView)
        textFieldStackView.addArrangedSubview(emailMarginView)
        textFieldStackView.addArrangedSubview(pwMarginView)
        emailMarginView.addSubview(emailTextField)
        emailMarginView.addSubview(emailLineView)
        pwMarginView.addSubview(pwTextField)
        pwMarginView.addSubview(pwLineView)
    }
    
    private func setNav() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setButtonAction() {
        signupButton.addTarget(self, action: #selector(presentSignupView(_:)), for: .touchUpInside)
    }
    
    // MARK: - Action
    @objc
    func presentSignupView(_ sender: UIButton) {
        let signupContainerVC = SignupContainerViewController()
        navigationController?.pushViewController(signupContainerVC, animated: true)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // FIXME: 여기 뒤에 배경 동영상 넣어야함
        view.backgroundColor = .darkGray
        
        initView()
        configureLayout()
        setButtonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNav()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCornerRadius()
    }
    
    // MARK: - Layout
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: 36),
            subLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            textFieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textFieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                         constant: -20),
            textFieldStackView.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 61),
            emailTextField.topAnchor.constraint(equalTo: emailMarginView.topAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: emailMarginView.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: emailMarginView.trailingAnchor),
            emailTextField.bottomAnchor.constraint(equalTo: emailLineView.topAnchor, constant: -4),
            emailLineView.bottomAnchor.constraint(equalTo: emailMarginView.bottomAnchor),
            emailLineView.leadingAnchor.constraint(equalTo: emailMarginView.leadingAnchor),
            emailLineView.trailingAnchor.constraint(equalTo: emailMarginView.trailingAnchor),
            emailLineView.heightAnchor.constraint(equalToConstant: 1),
            pwTextField.topAnchor.constraint(equalTo: pwMarginView.topAnchor),
            pwTextField.leadingAnchor.constraint(equalTo: pwMarginView.leadingAnchor),
            pwTextField.trailingAnchor.constraint(equalTo: pwMarginView.trailingAnchor),
            pwTextField.bottomAnchor.constraint(equalTo: pwLineView.topAnchor, constant: -4),
            pwLineView.bottomAnchor.constraint(equalTo: pwMarginView.bottomAnchor),
            pwLineView.leadingAnchor.constraint(equalTo: pwMarginView.leadingAnchor),
            pwLineView.trailingAnchor.constraint(equalTo: pwMarginView.trailingAnchor),
            pwLineView.heightAnchor.constraint(equalToConstant: 1),
            buttonStackView.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor,
                                                    constant: 68),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signupButton.heightAnchor.constraint(equalTo: signupButton.widthAnchor,
                                                 multiplier: 0.14)
        ])
    }
    
    private func configureCornerRadius() {
        let corner: CGFloat = (UIScreen.main.bounds.width - 20*2) / 83.75
        loginButton.layer.cornerRadius = corner
        signupButton.layer.cornerRadius = corner
    }
}
