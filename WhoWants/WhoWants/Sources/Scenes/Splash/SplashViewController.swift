//
//  SplashViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/12/13.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    // MARK: - UI
    let animationView: AnimationView = {
        let animationView = AnimationView(name: "splash")
        animationView.contentMode = .scaleAspectFill
        animationView.backgroundColor = .clear
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    // MARK: - Action
    func overSplash() {
        guard let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first,
              let signinVC = UIStoryboard(name: "Signin", bundle: nil)
                .instantiateViewController(withIdentifier: "Signin") as? UINavigationController else { return }
        
        keyWindow.rootViewController = signinVC
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        self.view.addSubview(animationView)
        configureLayout()
        
        animationView.play { _ in
            self.overSplash()
        }
    }
    
    deinit {
        print("deInit")
    }
    
    // MARK: - Layout
    private func configureLayout() {
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: self.view.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
