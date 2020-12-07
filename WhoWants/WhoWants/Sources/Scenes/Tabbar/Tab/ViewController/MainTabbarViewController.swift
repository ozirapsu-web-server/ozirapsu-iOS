//
//  MainTabbarViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/29.
//

import UIKit

class MainTabbarViewController: UITabBarController {
    static let identifier = "MainTabbarVC"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.delegate = self
    }
}

extension MainTabbarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if viewController is HomeViewController {
//            return true
//        } else if viewController is MyPageViewController {
//            return true
//        } else {
//            return false
//        }
        return true
    }
}
