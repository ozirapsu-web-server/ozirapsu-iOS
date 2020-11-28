//
//  NickInputViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/28.
//

import UIKit

enum NickInputText: String {
    case title = "닉네임을\n입력해주세요"
    case nickPlaceholder = "7글자 이내로 설정해주세요"
}

class NickInputViewController: UIViewController {
    // MARK: - UI
    var titleLabel: UILabel = {
        var label = UILabel()
        label.text = NickInputText.title.rawValue
        label.textColor = .mainblack
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var nickMarginView: UIView = {
        var uiView = UIView()
        uiView.backgroundColor = .clear
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    var nickTextfield: UITextField = {
        var textField = UITextField()
        textField.borderStyle = .none
        textField.keyboardType = .default
        textField.returnKeyType = .done
        let attributeText = NSAttributedString(string: NickInputText.nickPlaceholder.rawValue,
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
    
    private func appearAnimate() {
        self.view.alpha = 0
        self.view.transform = CGAffineTransform(translationX: 50, y: 0)
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 1
            self.view.transform = .identity
        })
    }
    
    @objc
    func deleteText(_ sender: UIButton) {
        nickTextfield.text?.removeAll()
    }
    
    @objc
    func complete(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.transform = CGAffineTransform(translationX: -50, y: 0)
            self.view.alpha = 0
        }, completion: { isCompletion in
            self.completion?(self.nickTextfield.text!)
        })
    }
    
    // MARK: - Init
    private func initView() {
        view.addSubview(titleLabel)
        view.addSubview(nickMarginView)
        nickMarginView.addSubview(nickTextfield)
        nickMarginView.addSubview(lineView)
        view.addSubview(completeButton)
        view.addSubview(cancelButton)
    }
    
    private func setDelegate() {
        nickTextfield.delegate = self
    }
    
    private func setButtonAction() {
        cancelButton.addTarget(self, action: #selector(deleteText(_:)), for: .touchUpInside)
        completeButton.addTarget(self, action: #selector(complete(_:)), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        setDelegate()
        setButtonAction()
        
        configureLayout()
        configureCornerRadius()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appearAnimate()
    }
    
    // MARK: - Layout
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 31),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nickMarginView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            nickMarginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nickMarginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nickTextfield.topAnchor.constraint(equalTo: nickMarginView.topAnchor),
            nickTextfield.leadingAnchor.constraint(equalTo: nickMarginView.leadingAnchor),
            nickTextfield.trailingAnchor.constraint(equalTo: nickMarginView.trailingAnchor),
            lineView.topAnchor.constraint(equalTo: nickTextfield.bottomAnchor, constant: 4),
            lineView.leadingAnchor.constraint(equalTo: nickMarginView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: nickMarginView.trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: nickMarginView.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            completeButton.topAnchor.constraint(equalTo: nickMarginView.bottomAnchor, constant: 139),
            completeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            completeButton.heightAnchor.constraint(equalTo: completeButton.widthAnchor, multiplier: 0.14),
            cancelButton.centerYAnchor.constraint(equalTo: nickMarginView.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6)
        ])
    }
    
    private func configureCornerRadius() {
        let corner: CGFloat = (UIScreen.main.bounds.width - 20*2) / 83.75
        completeButton.layer.cornerRadius = corner
    }
}

extension NickInputViewController: SignupInputable {
    var type: SignupInputType {
        return .nickname
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

extension NickInputViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.count >= 7 {
            completeButton.isUserInteractionEnabled = false
            completeButton.backgroundColor = .graytext
        } else {
            if text.isEmpty {
                lineView.backgroundColor = .graytext
                cancelButton.isHidden = true
            } else {
                lineView.backgroundColor = .mainblack
                cancelButton.isHidden = false
            }
            completeButton.isUserInteractionEnabled = true
            completeButton.backgroundColor = .mainblack
        }
    }
}
