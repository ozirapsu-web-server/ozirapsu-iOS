//
//  FundrasingDetailViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/12/08.
//

import UIKit

enum FundrasingDetailText: String {
    case title = "후원츠를 도와주세요!"
}

class FundrasingDetailViewController: UIViewController {
    // MARK: - UI
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = FundrasingDetailText.title.rawValue
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .mainblack
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .automatic
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    private func setNav() {
        self.navigationController?.navigationBar.tintColor = .mainblack
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageName.backBtn),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(back(_:)))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageName.btn_edit),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(write(_:)))
        self.navigationItem.titleView = titleLabel
    }
    
    // MARK: - Action
    @objc
    func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func write(_ sender: Any) {
        print("write")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        setNav()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
