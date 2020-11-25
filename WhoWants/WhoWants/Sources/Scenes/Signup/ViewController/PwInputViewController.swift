//
//  PwInputViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/25.
//

import UIKit

class PwInputViewController: UIViewController {
    // MARK: - Action
    var completion: ((String) -> Void)?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
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
