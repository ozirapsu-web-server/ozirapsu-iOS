//
//  PwInputViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/25.
//

import UIKit

enum PwInputText: String {
    case title = "비밀번호를\n입력해주세요"
    case pwPlaceholder = "비밀번호 입력"
    case confirmPlaceholder = "비밀번호 확인"
}

class PwInputViewController: UIViewController {
    // MARK: - UI
    var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .mainblack
        label.numberOfLines = 0
        label.text = PwInputText.title.rawValue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var textFieldStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 54
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var pwMarginView: UIView = {
        var uiView = UIView()
        uiView.backgroundColor = .clear
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    var pwTextField: UITextField = {
        var textField = UITextField()
        textField.borderStyle = .none
        let attributeText = NSAttributedString(string: PwInputText.pwPlaceholder.rawValue,
                                               attributes: [.font: UIFont.systemFont(ofSize: 14)])
        textField.attributedPlaceholder = attributeText
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var pwLineView: UIView = {
        var uiView = UIView()
        uiView.backgroundColor = .lightGray
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    var confirmMarginView: UIView = {
        var uiView = UIView()
        uiView.backgroundColor = .clear
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    var confirmTextField: UITextField = {
        var textField = UITextField()
        textField.borderStyle = .none
        let attributeText = NSAttributedString(string: PwInputText.confirmPlaceholder.rawValue,
                                               attributes: [.font: UIFont.systemFont(ofSize: 14)])
        textField.attributedPlaceholder = attributeText
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var confirmLineView: UIView = {
        var uiView = UIView()
        uiView.backgroundColor = .lightGray
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
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
    
    var pwCancelButton: UIButton = {
        var btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: ImageName.cancelBtn), for: .normal)
        btn.tintColor = .mainblack
        btn.isHidden = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var confirmCancelButton: UIButton = {
        var btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: ImageName.cancelBtn), for: .normal)
        btn.tintColor = .mainblack
        btn.isHidden = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - Action
    var completion: ((String) -> Void)?
    
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
        view.addSubview(textFieldStackView)
        textFieldStackView.addArrangedSubview(pwMarginView)
        textFieldStackView.addArrangedSubview(confirmMarginView)
        pwMarginView.addSubview(pwTextField)
        pwMarginView.addSubview(pwLineView)
        confirmMarginView.addSubview(confirmTextField)
        confirmMarginView.addSubview(confirmLineView)
        view.addSubview(completeButton)
        view.addSubview(pwCancelButton)
        view.addSubview(confirmCancelButton)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        initView()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appearAnimate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCornerRadius()
    }
    
    deinit {
        print("Pw Input Deinit")
    }
    
    // MARK: - Layout
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 31),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textFieldStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            textFieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textFieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pwTextField.leadingAnchor.constraint(equalTo: pwMarginView.leadingAnchor),
            pwTextField.topAnchor.constraint(equalTo: pwMarginView.topAnchor),
            pwTextField.trailingAnchor.constraint(equalTo: pwMarginView.trailingAnchor),
            pwLineView.topAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: 4),
            pwLineView.leadingAnchor.constraint(equalTo: pwMarginView.leadingAnchor),
            pwLineView.trailingAnchor.constraint(equalTo: pwMarginView.trailingAnchor),
            pwLineView.heightAnchor.constraint(equalToConstant: 1),
            confirmTextField.leadingAnchor.constraint(equalTo: confirmMarginView.leadingAnchor),
            confirmTextField.trailingAnchor.constraint(equalTo: confirmMarginView.trailingAnchor),
            confirmTextField.topAnchor.constraint(equalTo: confirmMarginView.topAnchor),
            confirmLineView.topAnchor.constraint(equalTo: confirmTextField.bottomAnchor, constant: 4),
            confirmLineView.leadingAnchor.constraint(equalTo: confirmMarginView.leadingAnchor),
            confirmLineView.trailingAnchor.constraint(equalTo: confirmMarginView.trailingAnchor),
            confirmLineView.heightAnchor.constraint(equalToConstant: 1),
            confirmLineView.bottomAnchor.constraint(equalTo: confirmMarginView.bottomAnchor),
            completeButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 60),
            completeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            completeButton.heightAnchor.constraint(equalTo: completeButton.widthAnchor, multiplier: 0.14),
            pwCancelButton.centerYAnchor.constraint(equalTo: pwMarginView.centerYAnchor),
            pwCancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),
            confirmCancelButton.centerYAnchor.constraint(equalTo: confirmMarginView.centerYAnchor),
            confirmCancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6)
        ])
    }
    
    private func configureCornerRadius() {
        let corner: CGFloat = (UIScreen.main.bounds.width - 20*2) / 83.75
        completeButton.layer.cornerRadius = corner
    }
}

extension PwInputViewController: SignupInputable {
    var type: SignupInputType {
        return .pw
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

extension PwInputViewController: UITextViewDelegate {
    
}
