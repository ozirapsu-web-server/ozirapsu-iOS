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
