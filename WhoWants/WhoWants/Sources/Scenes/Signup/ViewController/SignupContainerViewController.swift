//
//  SignupContainerViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/25.
//

import UIKit

enum SignupText: String {
    case signup = "회원가입"
}

enum SignupInputType: Int {
    case email = 0, pw, nickname, gender
    
    func instantiateVC() -> SignupInputable {
        switch self {
        case .email: return EmailInputViewController()
        case .pw: return PwInputViewController()
        default: return EmailInputViewController()
        }
    }
    
    func getKey() -> String {
        switch self {
        case .email: return "email"
        case .pw: return "pw"
        default: return ""
        }
    }
}

protocol SignupInputable {
    var type: SignupInputType { get }
    var transfer: ((String) -> Void)? { get set }
}

class SignupContainerViewController: UIViewController {
    // MARK: - UI
    var progressView: UIProgressView = {
        var progressView = UIProgressView(progressViewStyle: .default)
        progressView.progress = 0.25
        progressView.progressTintColor = .mainblack
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    var containerView: UIView = {
        var uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    var childInputVC: SignupInputable?
    
    // MARK: - Data
    var userInform: [String: String] = [:]
    
    // MARK: - Action
    private func addChildView(type: SignupInputType) {
        self.childInputVC = type.instantiateVC()
        guard let castingVC = self.childInputVC as? UIViewController else { return }
        self.addChild(castingVC)
        castingVC.view.frame = containerView.bounds
        containerView.addSubview(castingVC.view)
        castingVC.didMove(toParent: self)
        
        childInputVC?.transfer = { [weak self] inform in
            self?.userInform[type.getKey()] = inform
        }
    }
    
    private func removeChildView() {
        guard let castingVC = self.childInputVC as? UIViewController else { return }
        castingVC.willMove(toParent: nil)
        castingVC.view.removeFromSuperview()
        castingVC.removeFromParent()
    }
    
    @objc
    func onChange(_ notification: NSNotification) {
        print("")
    }
    
    // MARK: - Init
    private func initView() {
        view.addSubview(progressView)
        view.addSubview(containerView)
    }
    
    private func setNav() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .mainblack
        navigationItem.title = SignupText.signup.rawValue
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(onChange(_:)), name: .completeTransfer, object: nil)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        initView()
        configureLayout()
        
        addChildView(type: .email)
        addObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNav()
    }
    
    // MARK: - Layout
    private func configureLayout() {
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: progressView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
