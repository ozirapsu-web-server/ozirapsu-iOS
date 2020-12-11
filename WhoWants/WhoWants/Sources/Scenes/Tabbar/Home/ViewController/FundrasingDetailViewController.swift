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
        let attributeText = NSAttributedString(string: FundrasingDetailText.title.rawValue,
                                               attributes: [.font: UIFont(name: FontName.notosans_medium,
                                                                          size: 18)!,
                                                            .kern: -0.72,
                                                            .foregroundColor: UIColor.mainblack])
        label.attributedText = attributeText
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
    
    let topContainerView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        return uiView
    }()
    
    lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width,
                                 height: UIScreen.main.bounds.width*0.66)
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(FundraisingImageCell.self,
                                forCellWithReuseIdentifier: FundraisingImageCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Init
    private func setNav() {
        self.navigationController?.navigationBar.transform = .identity
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
    
    private func initView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(topContainerView)
        topContainerView.addSubview(imageCollectionView)
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
        initView()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Layout
    private func configureLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imageCollectionView.topAnchor.constraint(equalTo: topContainerView.topAnchor),
            imageCollectionView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor),
            imageCollectionView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor),
            imageCollectionView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            imageCollectionView.heightAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.66)
        ])
    }
}

extension FundrasingDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let fundraisingImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: FundraisingImageCell.identifier,
                                                                            for: indexPath)
                as? FundraisingImageCell else { return UICollectionViewCell() }
        fundraisingImageCell.bind()
        return fundraisingImageCell
    }
}

extension FundrasingDetailViewController: UICollectionViewDelegate {
    
}
