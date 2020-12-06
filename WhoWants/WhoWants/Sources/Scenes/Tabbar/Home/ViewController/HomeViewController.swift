//
//  MainViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/29.
//

import UIKit

protocol FundraiseHeaderAble {
    var isInit: Bool { get set }
}

protocol FundraiseCellAble {
    
}

enum HomeText: String {
    case title = "whowants"
}

class HomeViewController: UIViewController {
    static let identifier = "HomeVC"

    // MARK: - UI
    lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 36
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 20*2, height: 200)
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        collectionView.register(FundraisingCell.self,
                                forCellWithReuseIdentifier: FundraisingCell.identifier)
        collectionView.register(FundraisingCurHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: FundraisingCurHeaderView.identifier)
        collectionView.register(FundraisingHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: FundraisingHeaderView.identifier)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Init
    private func initView() {
        self.view.addSubview(homeCollectionView)
    }
    
    private func setNav() {
        let logoImage = UIImageView(image: UIImage(named: ImageName.logo))
        logoImage.contentMode = .scaleAspectFit
        navigationItem.titleView = logoImage
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - Action
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            homeCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            homeCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 0 }
        else { return 5 }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // FIXME: 셀 들어갈 모델 결정되면 Cell Model 데이터 추상화하기
        guard let fundraseCell = collectionView
                .dequeueReusableCell(withReuseIdentifier: FundraisingCell.identifier,
                                     for: indexPath) as? FundraisingCell else {
            return UICollectionViewCell()
        }
        
        return fundraseCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind != UICollectionView.elementKindSectionHeader { return UICollectionReusableView() }
        if indexPath.section == 0 {
            let reusableView = collectionView
                .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                            withReuseIdentifier: FundraisingHeaderView.identifier,
                                                            for: indexPath) as! FundraisingHeaderView
            reusableView.setHeader(HeaderDataDTO(name: "이성민", message: "Hi 안녕하세요"))
            return reusableView
        } else {
            let reusableCurView = collectionView
                .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                  withReuseIdentifier: FundraisingCurHeaderView.identifier,
                                                  for: indexPath) as! FundraisingCurHeaderView
            return reusableCurView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard let fundraisingCell = cell as? FundraisingCell else { return }
        
        if fundraisingCell.isInit {
            fundraisingCell.transform = CGAffineTransform(translationX: 0, y: view.bounds.height)
            fundraisingCell.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                fundraisingCell.transform = .identity
                fundraisingCell.alpha = 1
            }, completion: { isCompletion in
                fundraisingCell.isInit = false
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String,
                        at indexPath: IndexPath) {
        if elementKind != UICollectionView.elementKindSectionHeader { return }
        guard var headerView = view as? FundraiseHeaderAble else { return }
        if !headerView.isInit { return }
        
        view.alpha = 0
        view.transform = CGAffineTransform(translationX: 0, y: view.bounds.height)
        
        UIView.animate(withDuration: 0.5, animations: {
            view.alpha = 1
            view.transform = .identity
        }, completion: { isCompletion in
            headerView.isInit = false
        })
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerView = self.collectionView(collectionView,
                                             viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
                                             at: IndexPath(row: 0, section: section))
        
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: 70),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
}
