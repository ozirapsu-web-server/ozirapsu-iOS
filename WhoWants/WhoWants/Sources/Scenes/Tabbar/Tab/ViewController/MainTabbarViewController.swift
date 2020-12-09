//
//  MainTabbarViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/29.
//

import UIKit

class MainTabbarViewController: UITabBarController {
    static let identifier = "MainTabbarVC"
    

    var ActionViewController = UIStoryboard.init(name: "OpenFundraising", bundle: nil).instantiateViewController(withIdentifier: "InputGaolVC")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.delegate = self
        
        // tab bar item image 설정
        self.tabBarController?.tabBar.items![0].image = UIImage(named: "ic_home")
        
        
        
        self.tabBarController?.tabBar.items![2].image = UIImage(named: "ic_profile")
        
        
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
        
        
        if viewController.isKind(of: ActionViewController) {
            
            let sb = UIStoryboard.init(name: "OpenFundraising", bundle: nil)
            
            let vc = sb.instantiateViewController(withIdentifier: "InputGaolVC")
             vc.modalPresentationStyle = .overFullScreen
             self.present(vc, animated: true, completion: nil)
             return false
          }
        
        return true
    }
    
    /*
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if tabBarController?.selectedIndex == 1 {
            
            print("탭바 눌림")
            
            let sb = UIStoryboard.init(name: "OpenFundraising", bundle: nil)
            
            let vc = sb.instantiateViewController(withIdentifier: "InputGaolVC")
            
            vc.hidesBottomBarWhenPushed = true
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }*/
    
}
