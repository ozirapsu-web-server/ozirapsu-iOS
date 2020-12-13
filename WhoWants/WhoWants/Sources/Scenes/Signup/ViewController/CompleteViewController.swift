//
//  CompleteViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/29.
//

import UIKit
import Lottie

enum CompleteText: String {
    case title = "회원가입이\n완료되었습니다!"
    case subtitle = "지금 바로 모금함을 개설해보세요"
    case makeBtn = "모금함 개설하기"
    case afterBtn = "나중에 할게요"
}

class CompleteViewController: UIViewController {
    // MARK: - UI
    var animationView: AnimationView = {
        var animationView = AnimationView(name: "confetti")
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .repeat(Float.greatestFiniteMagnitude)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
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
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        let attributeText = NSAttributedString(string: CompleteText.title.rawValue,
                                               attributes: [.font: UIFont(name: FontName.notosans_bold,
                                                                          size: 20)!,
                                                            .paragraphStyle: paragraphStyle,
                                                            .kern: -0.8,
                                                            .foregroundColor: UIColor.mainblack])
        label.attributedText = attributeText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var subTitleLabel: UILabel = {
        var label = UILabel()
        let attributeText = NSAttributedString(string: CompleteText.subtitle.rawValue,
                                               attributes: [.font: UIFont(name: FontName.notosans_regular,
                                                                          size: 12)!,
                                                            .kern: -0.48,
                                                            .foregroundColor: UIColor.mainblack])
        label.attributedText = attributeText
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
                                                            .font: UIFont(name: FontName.notosans_medium,
                                                                          size: 16)!,
                                                            .foregroundColor: UIColor.white])
        btn.setAttributedTitle(attributeText, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .whowantsblue
        return btn
    }()
    
    var afterButton: UIButton = {
        var btn = UIButton(type: .system)
        let attributeText = NSAttributedString(string: CompleteText.afterBtn.rawValue,
                                               attributes: [.kern: -0.64,
                                                            .font: UIFont(name: FontName.notosans_regular,
                                                                          size: 16)!,
                                                            .foregroundColor: UIColor.whowantsblue])
        btn.setAttributedTitle(attributeText, for: .normal)
        btn.backgroundColor = .clear
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - Data
    var userInform: [String: String] = [:]
    
    // MARK: - Action
    @objc
    func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func start(_ sender: UIButton) {
        signin()
        
//        let tabbarVC = UIStoryboard(name: "Tabbar", bundle: nil)
//                .instantiateViewController(withIdentifier: MainTabbarViewController.identifier)
//        UIApplication.shared.windows.filter { $0.isKeyWindow }
//            .first?.rootViewController = tabbarVC
    }
    
    private func signin() {
        let signinDTO = SigninParameterDTO(email: userInform[SignupInputType.email.getKey()]!,
                                           pw: userInform[SignupInputType.pw.getKey()]!)
        SigninService.shared.reqeustSignin(signinDTO) { result in
            switch result {
            case .success:
                let tabbarVC = UIStoryboard(name: "Tabbar", bundle: nil)
                        .instantiateViewController(withIdentifier: MainTabbarViewController.identifier)
                UIApplication.shared.windows.filter { $0.isKeyWindow }
                    .first?.rootViewController = tabbarVC
            case .requestErr:
                print("request Err")
            case .serverErr:
                print("Server Err")
            case .networkFail:
                print("network Fail")
            default:
                return
            }
        }
    }
    
    // MARK: - Init
    private func initView() {
        view.addSubview(animationView)
        view.addSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(subTitleLabel)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(makeButton)
        buttonStackView.addArrangedSubview(afterButton)
        
        animationView.play()
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
            animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.heightAnchor.constraint(equalTo: animationView.widthAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: animationView.bottomAnchor,
                                                constant: -33),
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
