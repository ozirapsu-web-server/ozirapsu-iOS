//
//  MyPageViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/29.
//

import UIKit

enum MyPageText: String {
    case title = "프로필"
    case emailState = "이메일"
    case introduceState = "한 줄 소개"
    case introducePlaceholder = "자신을 잘 나타내는 한 줄을 써주세요"
}

class MyPageViewController: UIViewController {
    static let identifier = "MyPageVC"
    
    // MARK: - UI
    let profileContainerView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    let profileButton: UIButton = {
        let btn = UIButton(type: .custom)
        // FIXME: 여기 디폴트 이미지 바꾸기
        btn.setImage(UIImage(named: ImageName.profile), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let profileCameraButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: ImageName.btn_profile), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "이성민"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .mainblack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let reviseButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: ImageName.btn_revise), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 38
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let emailContainerView: UIView = {
        let uiView = UIView()
        return uiView
    }()
    
    let emailStateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        label.text = MyPageText.emailState.rawValue
        label.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        // FIXME: 이메일 값에 따라 바뀌게 변경
        label.text = "jaeeunno1@gmail.com"
        label.textColor = .mainblack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLineView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    let introduceContainerView: UIView = {
        let uiView = UIView()
        return uiView
    }()
    
    let introduceStateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        label.text = MyPageText.introduceState.rawValue
        label.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let introduceTextfield: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .none
        let attributeText = NSAttributedString(string: MyPageText.introducePlaceholder.rawValue,
                                               attributes: [.font: UIFont.systemFont(ofSize: 14)])
        textfield.attributedPlaceholder = attributeText
        textfield.font = UIFont.systemFont(ofSize: 14)
        textfield.textColor = .mainblack
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let introduceLineView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    // MARK: - Init
    private func setNav() {
        self.navigationController?.navigationBar.titleTextAttributes =
            [.font: UIFont.boldSystemFont(ofSize: 18),
             .foregroundColor: UIColor.mainblack]
        self.navigationController?.navigationBar.topItem?.title = MyPageText.title.rawValue
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    private func initView() {
        self.view.addSubview(profileContainerView)
        profileContainerView.addSubview(profileButton)
        self.view.addSubview(profileCameraButton)
        self.view.addSubview(nicknameLabel)
        self.view.addSubview(reviseButton)
        self.view.addSubview(textStackView)
        textStackView.addArrangedSubview(emailContainerView)
        emailContainerView.addSubview(emailStateLabel)
        emailContainerView.addSubview(emailLabel)
        emailContainerView.addSubview(emailLineView)
        textStackView.addArrangedSubview(introduceContainerView)
        introduceContainerView.addSubview(introduceStateLabel)
        introduceContainerView.addSubview(introduceTextfield)
        introduceContainerView.addSubview(introduceLineView)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNav()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileButton.layer.cornerRadius = profileButton.bounds.width / 2
    }
    
    // MARK: - Layout
    private func configureLayout() {
        let radius: CGFloat = self.view.bounds.width * 0.27 / 2
        
        NSLayoutConstraint.activate([
            profileContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                      constant: 39),
            profileContainerView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                        multiplier: 0.27),
            profileContainerView.heightAnchor.constraint(equalTo: profileContainerView.widthAnchor),
            profileButton.topAnchor.constraint(equalTo: profileContainerView.topAnchor),
            profileButton.leadingAnchor.constraint(equalTo: profileContainerView.leadingAnchor),
            profileButton.trailingAnchor.constraint(equalTo: profileContainerView.trailingAnchor),
            profileButton.bottomAnchor.constraint(equalTo: profileContainerView.bottomAnchor),
            profileCameraButton.centerXAnchor.constraint(equalTo: profileContainerView.centerXAnchor,
                                                         constant: radius/sqrt(2)),
            profileCameraButton.centerYAnchor.constraint(equalTo: profileContainerView.centerYAnchor,
                                                         constant: radius/sqrt(2)),
            nicknameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nicknameLabel.topAnchor.constraint(equalTo: profileContainerView.bottomAnchor,
                                               constant: 23),
            reviseButton.centerYAnchor.constraint(equalTo: nicknameLabel.centerYAnchor),
            reviseButton.leadingAnchor.constraint(equalTo: nicknameLabel.trailingAnchor,
                                                  constant: 8),
            textStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textStackView.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 34),
            emailStateLabel.leadingAnchor.constraint(equalTo: emailContainerView.leadingAnchor),
            emailStateLabel.topAnchor.constraint(equalTo: emailContainerView.topAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: emailStateLabel.trailingAnchor, constant: 63),
            emailLabel.topAnchor.constraint(equalTo: emailStateLabel.topAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: emailContainerView.trailingAnchor),
            emailLineView.heightAnchor.constraint(equalToConstant: 1),
            emailLineView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 15),
            emailLineView.leadingAnchor.constraint(equalTo: emailContainerView.leadingAnchor),
            emailLineView.trailingAnchor.constraint(equalTo: emailContainerView.trailingAnchor),
            emailLineView.bottomAnchor.constraint(equalTo: emailContainerView.bottomAnchor),
            introduceStateLabel.leadingAnchor.constraint(equalTo: introduceContainerView.leadingAnchor),
            introduceStateLabel.topAnchor.constraint(equalTo: introduceContainerView.topAnchor),
            introduceTextfield.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            introduceTextfield.topAnchor.constraint(equalTo: introduceStateLabel.topAnchor),
            introduceTextfield.trailingAnchor.constraint(equalTo: introduceContainerView.trailingAnchor),
            introduceLineView.leadingAnchor.constraint(equalTo: introduceContainerView.leadingAnchor),
            introduceLineView.trailingAnchor.constraint(equalTo: introduceContainerView.trailingAnchor),
            introduceLineView.bottomAnchor.constraint(equalTo: introduceContainerView.bottomAnchor),
            introduceLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
