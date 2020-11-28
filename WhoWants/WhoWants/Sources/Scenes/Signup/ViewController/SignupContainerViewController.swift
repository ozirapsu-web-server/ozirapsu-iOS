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
    case email = 0, pw, phone, nickname
    
    func instantiateVC() -> SignupInputable {
        switch self {
        case .email: return EmailInputViewController()
        case .pw: return PwInputViewController()
        case .phone: return PhoneInputViewController()
        case .nickname: return NickInputViewController()
        }
    }
    
    func getKey() -> String {
        switch self {
        case .email: return "email"
        case .pw: return "pw"
        case .phone: return "phone"
        case .nickname: return "nickname"
        }
    }
    
    func calProgress() -> Float {
        switch self {
        case .email: return 0
        case .pw: return 0.25
        case .phone: return 0.5
        case .nickname: return 0.75
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
        progressView.progress = 0
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
    
    enum AnimationType {
        case show, dismiss
    }
    
    // MARK: - Action
    private func addChildView(type: SignupInputType, animateType: AnimationType) {
        self.childInputVC = type.instantiateVC()
        guard let castingVC = self.childInputVC as? UIViewController else { return }
        self.addChild(castingVC)
        castingVC.view.frame = containerView.bounds
        
        switch animateType {
        case .show:
            castingVC.view.transform = CGAffineTransform(translationX: 50, y: 0)
            castingVC.view.alpha = 0
        case .dismiss:
            castingVC.view.transform = CGAffineTransform(translationX: -50, y: 0)
            castingVC.view.alpha = 0
        }
        
        containerView.addSubview(castingVC.view)
        castingVC.didMove(toParent: self)
        UIView.animate(withDuration: 0.5, animations: {
            castingVC.view.transform = .identity
            castingVC.view.alpha = 1
        })
        
        childInputVC?.transfer = { [weak self] inform in
            self?.removeChildView(animateType: .show)
            
            self?.userInform[type.getKey()] = inform
            let curRaw = type.rawValue
            
            if curRaw == 3 {
                self?.progressView.setProgress(1, animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    let mainVC = MainViewController()
                    UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController = mainVC
                }
                return
            }
            let curInput = SignupInputType(rawValue: curRaw+1)!
            self?.progressView.setProgress(curInput.calProgress(), animated: true)
            self?.addChildView(type: curInput, animateType: .show)
        }
    }
    
    @objc
    func back(_ sender: Any) {
        guard let curType = childInputVC?.type else { return }
        if curType.rawValue == 0 {
            self.navigationController?.popViewController(animated: true)
        } else {
            removeChildView(animateType: .dismiss)
            
            let preInput = SignupInputType(rawValue: curType.rawValue-1)!
            
            self.progressView.setProgress(preInput.calProgress(), animated: true)
            self.addChildView(type: preInput, animateType: .dismiss)
        }
    }
    
    private func removeChildView(animateType: AnimationType) {
        guard let castingVC = self.childInputVC as? UIViewController else { return }
        
        switch animateType {
        case .show:
            UIView.animate(withDuration: 0.5, animations: {
                castingVC.view.transform = CGAffineTransform(translationX: -50, y: 0)
                castingVC.view.alpha = 0
            }, completion: { isCompletion in
                castingVC.willMove(toParent: nil)
                castingVC.view.removeFromSuperview()
                castingVC.removeFromParent()
            })
        case .dismiss:
            UIView.animate(withDuration: 0.5, animations: {
                castingVC.view.transform = CGAffineTransform(translationX: 50, y: 0)
                castingVC.view.alpha = 0
            }, completion: { isCompletion in
                castingVC.willMove(toParent: nil)
                castingVC.view.removeFromSuperview()
                castingVC.removeFromParent()
            })
        }
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
        let backbtn = UIBarButtonItem(image: UIImage(named: ImageName.backBtn),
                                      style: .plain,
                                      target: self,
                                      action: #selector(back(_:)))
        backbtn.imageInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = backbtn
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        initView()
        configureLayout()
        
        addChildView(type: .email, animateType: .show)
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
