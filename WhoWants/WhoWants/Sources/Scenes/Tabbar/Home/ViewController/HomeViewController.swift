//
//  MainViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/29.
//

import UIKit

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
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 20*2, height: 200)
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(FundraisingCell.self,
                                forCellWithReuseIdentifier: FundraisingCell.identifier)
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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 1
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
        if kind != UICollectionView.elementKindSectionHeader &&
            indexPath.section != 0 { return UICollectionReusableView() }
        let reusableView = collectionView
            .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                        withReuseIdentifier: FundraisingHeaderView.identifier,
                                                        for: indexPath) as! FundraisingHeaderView
        reusableView.setHeader(HeaderDataDTO(name: "이성민", message: "Hi 안녕하세요"))
        
        return reusableView
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section != 0 { return .zero }
        let headerView = self.collectionView(collectionView,
                                             viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
                                             at: IndexPath(row: 0, section: section))
        
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: 70),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
}
