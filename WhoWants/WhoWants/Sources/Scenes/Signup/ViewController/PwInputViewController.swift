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
    case invalid = "비밀번호를 잘못 입력했어요."
}

class PwInputViewController: UIViewController {
    // MARK: - UI
    var titleLabel: UILabel = {
        var label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.97
        label.attributedText = NSAttributedString(string: PwInputText.title.rawValue,
                                                  attributes: [.font: UIFont(name: FontName.notosans_bold,
                                                                             size: 18)!,
                                                               .kern: -0.72,
                                                               .paragraphStyle: paragraphStyle,
                                                               .foregroundColor: UIColor.mainblack])
        label.numberOfLines = 0
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
                                               attributes: [.font: UIFont(name: FontName.notosans_regular,
                                                                          size: 14)!,
                                                            .kern: -0.56])
        textField.textColor = .mainblack
        textField.attributedPlaceholder = attributeText
        textField.attributedText = attributeText
        textField.text = ""
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
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
                                               attributes: [.font: UIFont(name: FontName.notosans_regular,
                                                                          size: 14)!,
                                                            .kern: -0.56])
        textField.textColor = .mainblack
        textField.attributedPlaceholder = attributeText
        textField.attributedText = attributeText
        textField.text = ""
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var confirmLineView: UIView = {
        var uiView = UIView()
        uiView.backgroundColor = .lightGray
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    var invalidLabel: UILabel = {
        var label = UILabel()
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        let attributeText = NSAttributedString(string: PwInputText.invalid.rawValue,
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
    
    @objc
    func complete(_ sender: UIButton) {
        completion?(pwTextField.text!)
    }
    
    @objc
    func deleteText(_ sender: UIButton) {
        if sender == pwCancelButton {
            pwTextField.text?.removeAll()
        } else {
            confirmTextField.text?.removeAll()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        view.addSubview(invalidLabel)
    }
    
    private func setDelegate() {
        pwTextField.delegate = self
        confirmTextField.delegate = self
    }
    
    private func setButtonAction() {
        pwCancelButton.addTarget(self, action: #selector(deleteText(_:)), for: .touchUpInside)
        confirmCancelButton.addTarget(self, action: #selector(deleteText(_:)), for: .touchUpInside)
        completeButton.addTarget(self, action: #selector(complete(_:)), for: .touchUpInside)
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
            confirmCancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),
            invalidLabel.leadingAnchor.constraint(equalTo: textFieldStackView.leadingAnchor),
            invalidLabel.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 8)
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

extension PwInputViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == pwTextField {
            setPwTextfield(textField)
        } else {
            setConfirmTextfield(textField)
        }
    }
    
    private func setPwTextfield(_ textField: UITextField) {
        if textField.text == "" {
            pwCancelButton.isHidden = true
            pwLineView.backgroundColor = .lightGray
            completeButton.isUserInteractionEnabled = false
            completeButton.backgroundColor = UIColor(red: 170/255,
                                                     green: 170/255,
                                                     blue: 170/255,
                                                     alpha: 1.0)
            
            if confirmTextField.text != "" {
                invalidLabel.isHidden = false
                confirmLineView.backgroundColor = .red
            }
        } else {
            if textField.text == confirmTextField.text && textField.text != "" {
                invalidLabel.isHidden = true
                confirmLineView.backgroundColor = .mainblack
                completeButton.isUserInteractionEnabled = true
                completeButton.backgroundColor = .mainblack
            } else {
                if confirmTextField.text != "" {
                    invalidLabel.isHidden = false
                    confirmLineView.backgroundColor = .red
                    completeButton.isUserInteractionEnabled = false
                    completeButton.backgroundColor = UIColor(red: 170/255,
                                                             green: 170/255,
                                                             blue: 170/255,
                                                             alpha: 1.0)
                }
            }
            pwCancelButton.isHidden = false
            pwLineView.backgroundColor = .mainblack
        }
    }
    
    private func setConfirmTextfield(_ textField: UITextField) {
        if textField.text == "" {
            confirmCancelButton.isHidden = true
            confirmLineView.backgroundColor = .lightGray
            invalidLabel.isHidden = true
            completeButton.isUserInteractionEnabled = false
            completeButton.backgroundColor = UIColor(red: 170/255,
                                                     green: 170/255,
                                                     blue: 170/255,
                                                     alpha: 1.0)
        } else {
            confirmCancelButton.isHidden = false
            if textField.text != pwTextField.text {
                confirmLineView.backgroundColor = .red
                invalidLabel.isHidden = false
                completeButton.isUserInteractionEnabled = false
                completeButton.backgroundColor = UIColor(red: 170/255,
                                                         green: 170/255,
                                                         blue: 170/255,
                                                         alpha: 1.0)
            } else {
                invalidLabel.isHidden = true
                confirmLineView.backgroundColor = .mainblack
                completeButton.isUserInteractionEnabled = true
                completeButton.backgroundColor = .mainblack
            }
        }
    }
}
