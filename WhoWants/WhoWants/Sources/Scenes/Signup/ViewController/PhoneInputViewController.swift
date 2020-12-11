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
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.97
        label.attributedText = NSAttributedString(string: PhoneInputText.title.rawValue,
                                                  attributes: [.font: UIFont(name: FontName.notosans_bold,
                                                                             size: 18)!,
                                                               .kern: -0.72,
                                                               .paragraphStyle: paragraphStyle,
                                                               .foregroundColor: UIColor.mainblack])
        label.numberOfLines = 0
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
        let attributeText = NSAttributedString(string: PhoneInputText.phonePlaceholder.rawValue,
                                               attributes: [.font: UIFont(name: FontName.notosans_regular,
                                                                          size: 14)!,
                                                            .kern: -0.56])
        textField.textColor = .mainblack
        textField.attributedPlaceholder = attributeText
        textField.attributedText = attributeText
        textField.text = ""
        textField.borderStyle = .none
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var lineView: UIView = {
        var uiView = UIView()
        uiView.backgroundColor = .lightGray
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    var cancelButton: UIButton = {
        var btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: ImageName.cancelBtn), for: .normal)
        btn.tintColor = .mainblack
        btn.isHidden = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var completeButton: UIButton = {
        var btn = UIButton(type: .system)
        btn.backgroundColor = .graytext
        let attributeText = NSAttributedString(string: EmailInputText.next.rawValue,
                                               attributes: [.font: UIFont(name: FontName.notosans_medium,
                                                                          size: 16)!,
                                                            .kern: -0.64,
                                                            .foregroundColor: UIColor.white])
        btn.setAttributedTitle(attributeText, for: .normal)
        btn.clipsToBounds = true
        btn.isUserInteractionEnabled = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - Action
    var completion: ((String) -> Void)?
    
    @objc
    func complete(_ sender: UIButton) {
        completion?(phoneTextfield.text!)
    }
    
    @objc
    func deleteText(_ sender: UIButton) {
        phoneTextfield.text?.removeAll()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Init
    private func initView() {
        view.addSubview(titleLabel)
        view.addSubview(phoneMarginView)
        phoneMarginView.addSubview(phoneTextfield)
        phoneMarginView.addSubview(lineView)
        view.addSubview(completeButton)
        view.addSubview(cancelButton)
    }
    
    private func setDelegate() {
        phoneTextfield.delegate = self
    }
    
    private func setButtonAction() {
        completeButton.addTarget(self, action: #selector(complete(_:)), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(deleteText(_:)), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        print("PhoneInputController Deinit")
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
            completeButton.heightAnchor.constraint(equalTo: completeButton.widthAnchor, multiplier: 0.14),
            cancelButton.centerYAnchor.constraint(equalTo: phoneMarginView.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6)
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

extension PhoneInputViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // FIXME: 여기서 '-' 추가했을 때, 포함되어야 할 UI 있으면 말해줘
        guard let text = textField.text else { return }
        if text.count < 11 {
            if text.isEmpty {
                lineView.backgroundColor = .graytext
                cancelButton.isHidden = true
            } else {
                lineView.backgroundColor = .mainblack
                cancelButton.isHidden = false
            }
            completeButton.isUserInteractionEnabled = false
            completeButton.backgroundColor = .graytext
        } else {
            completeButton.isUserInteractionEnabled = true
            completeButton.backgroundColor = .mainblack
        }
    }
}
