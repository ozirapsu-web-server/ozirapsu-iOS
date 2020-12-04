//
//  MainViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/11/29.
//

import UIKit

enum HomeText: String {
    case title = "whowants"
}

class HomeViewController: UIViewController {
    static let identifier = "HomeVC"

    // MARK: - UI
    lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
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
        navigationController?.navigationBar.topItem?.title = HomeText.title.rawValue
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor.whowantsblue
        ]
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
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind != UICollectionView.elementKindSectionHeader { return UICollectionReusableView() }
        let reusableView = collectionView
            .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                        withReuseIdentifier: FundraisingHeaderView.identifier,
                                                        for: indexPath) as! FundraisingHeaderView
        return reusableView
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
