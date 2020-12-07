//
//  MyPageViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/29.
//

import UIKit

class MyPageViewController: UIViewController {
    static let identifier = "MyPageVC"
    
    // MARK: - UI
    let profileButton: UIButton = {
        let btn = UIButton(type: .system)
        
        return btn
    }()
    
    // MARK: - Init
    private func setNav() {
        self.navigationItem.title = "프로필"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNav()
    }
}
