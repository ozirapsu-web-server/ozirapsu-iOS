//
//  PwInputViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/25.
//

import UIKit

enum PwInputText: String {
    case title = "비밀번호를\n입력해주세요"
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
    
    // MARK: - Action
    var completion: ((String) -> Void)?
    
    // MARK: - Init
    private func initView() {
        view.addSubview(titleLabel)
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
        self.view.transform = CGAffineTransform(translationX: 100, y: 0)
        self.view.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.transform = .identity
            self.view.alpha = 1
        })
    }
    
    deinit {
        print("Pw Input Deinit")
    }
    
    // MARK: - Layout
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 31),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
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
