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

class SignupContainerViewController: UIViewController {
    // MARK: - UI
    var progressView: UIProgressView = {
        var progressView = UIProgressView(progressViewStyle: .default)
        progressView.progress = 0
        progressView.progressTintColor = .mainblack
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    // MARK: - Init
    private func initView() {
        view.addSubview(progressView)
    }
    
    private func setNav() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .mainblack
        navigationItem.title = SignupText.signup.rawValue
        navigationController?.navigationBar.topItem?.title = ""
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
        setNav()
    }
    
    // MARK: - Layout
    private func configureLayout() {
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}
