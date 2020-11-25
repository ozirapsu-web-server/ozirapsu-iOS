//
//  EmailInputViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/25.
//

import UIKit

class EmailInputViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
    }
}

extension EmailInputViewController: SignupInputable {
    var type: SignupInputType {
        return .email
    }
}
