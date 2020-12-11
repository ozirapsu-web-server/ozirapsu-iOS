//
//  CompleteViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/29.
//

import UIKit

enum CompleteText: String {
    case title = "회원가입이\n완료되었습니다"
    case subtitle = "지금 바로 모금함을 개설해보세요"
    case makeBtn = "모금함 개설하기"
    case afterBtn = "나중에 할게요"
}

class CompleteViewController: UIViewController {
    // MARK: - UI
    var completeImageView: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: ImageName.complete))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var labelStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.spacing = 9
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = CompleteText.title.rawValue
        label.textAlignment = .center
        label.textColor = .mainblack
        label.numberOfLines = 0
        return label
    }()
    
    var subTitleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = CompleteText.subtitle.rawValue
        label.textColor = .mainblack
        return label
    }()
    
    var buttonStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.spacing = 11
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var makeButton: UIButton = {
        var btn = UIButton(type: .system)
        btn.clipsToBounds = true
        let attributeText = NSAttributedString(string: CompleteText.makeBtn.rawValue,
                                               attributes: [.kern: -0.64,
                                                            .font: UIFont.boldSystemFont(ofSize: 16),
                                                            .foregroundColor: UIColor.white])
        btn.setAttributedTitle(attributeText, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .whowantsblue
        return btn
    }()
    
    var afterButton: UIButton = {
        var btn = UIButton(type: .system)
        btn.setTitle(CompleteText.afterBtn.rawValue, for: .normal)
        btn.setTitleColor(.mainblack, for: .normal)
        btn.backgroundColor = .clear
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - Action
    @objc
    func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func start(_ sender: UIButton) {
        let tabbarVC = UIStoryboard(name: "Tabbar", bundle: nil)
                .instantiateViewController(withIdentifier: MainTabbarViewController.identifier)
        UIApplication.shared.windows.filter { $0.isKeyWindow }
            .first?.rootViewController = tabbarVC
    }
    
    // MARK: - Init
    private func initView() {
        view.addSubview(completeImageView)
        view.addSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(subTitleLabel)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(makeButton)
        buttonStackView.addArrangedSubview(afterButton)
    }
    
    private func setNav() {
        navigationController?.navigationBar.tintColor = .mainblack
        navigationItem.title = SignupText.signup.rawValue
        navigationItem.hidesBackButton = true
    }
    
    private func setButtonAction() {
        afterButton.addTarget(self, action: #selector(start(_:)), for: .touchUpInside)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        initView()
        setButtonAction()
        configureLayout()
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
            completeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                   constant: 146),
            completeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelStackView.topAnchor.constraint(equalTo: completeImageView.bottomAnchor,
                                                constant: 25),
            labelStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                    constant: -93),
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            makeButton.heightAnchor.constraint(equalTo: makeButton.widthAnchor, multiplier: 0.14)
        ])
    }
    
    private func configureCornerRadius() {
        let corner: CGFloat = (UIScreen.main.bounds.width - 20*2) / 83.75
        makeButton.layer.cornerRadius = corner
    }
}
