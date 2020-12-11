//
//  FundrasingDetailViewController.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/12/08.
//

import UIKit

enum FundrasingDetailText: String {
    case title = "후원츠를 도와주세요!"
    case surporter = "서포터즈"
    case new = "새 소식"
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
        collectionView.backgroundColor = .clear
        collectionView.register(FundraisingImageCell.self,
                                forCellWithReuseIdentifier: FundraisingImageCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    let middleContainerView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1.0)
        return uiView
    }()
    
    let middleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // 새소식 + 서포터즈 뷰 포함하는 StackView
    let stateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 7
        return stackView
    }()
    
    let surporterView: UIView = {
        let uiView = UIView()
        uiView.clipsToBounds = true
        uiView.backgroundColor = .white
        return uiView
    }()
    
    let surporterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let surporterLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageName.surporter)
        return imageView
    }()
    
    let surporterLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: FundrasingDetailText.surporter.rawValue,
                                                  attributes: [.font: UIFont(name: FontName.notosans_regular,
                                                                             size: 12)!,
                                                               .kern: -0.48,
                                                               .foregroundColor: UIColor.mainblack])
        return label
    }()
    
    let surporterCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "4명",
                                                  attributes: [.font: UIFont(name: FontName.notosans_medium,
                                                                             size: 20)!,
                                                               .kern: -0.8,
                                                               .foregroundColor: UIColor.mainblack])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let newsView: UIView = {
        let uiView = UIView()
        uiView.clipsToBounds = true
        uiView.backgroundColor = .white
        return uiView
    }()
    
    let newsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let newsLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageName.new)
        return imageView
    }()
    
    let newsLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: FundrasingDetailText.new.rawValue,
                                                  attributes: [.font: UIFont(name: FontName.notosans_regular,
                                                                             size: 12)!,
                                                               .kern: -0.48,
                                                               .foregroundColor: UIColor.mainblack])
        return label
    }()
    
    let newsCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "0개",
                                                  attributes: [.font: UIFont(name: FontName.notosans_medium,
                                                                             size: 20)!,
                                                               .kern: -0.8,
                                                               .foregroundColor: UIColor.whowantsblue])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stateView: UIView = {
        let uiView = UIView()
        return uiView
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
        topContainerView.addSubview(pageControl)
        
        contentStackView.addArrangedSubview(middleContainerView)
        middleContainerView.addSubview(middleStackView)
        middleStackView.addArrangedSubview(stateStackView)
        
        stateStackView.addArrangedSubview(surporterView)
        surporterView.addSubview(surporterStackView)
        surporterStackView.addArrangedSubview(surporterLogoImageView)
        surporterStackView.addArrangedSubview(surporterLabel)
        surporterView.addSubview(surporterCountLabel)
        
        stateStackView.addArrangedSubview(newsView)
        newsView.addSubview(newsStackView)
        newsStackView.addArrangedSubview(newsLogoImageView)
        newsStackView.addArrangedSubview(newsLabel)
        newsView.addSubview(newsCountLabel)
        
        pageControl.numberOfPages = detailData.count
    }
    
    // MARK: - Data
    var detailData: [String] = ["Hi", "Hi", "Hi", "Hi"]
    
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
        let stateViewCorner: CGFloat = (self.view.bounds.width - 20*2 - 7)/2/27
        surporterView.layer.cornerRadius = stateViewCorner
        newsView.layer.cornerRadius = stateViewCorner
        
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
            imageCollectionView.heightAnchor.constraint(equalTo: topContainerView.widthAnchor,
                                                        multiplier: 0.66),
            middleStackView.topAnchor.constraint(equalTo: middleContainerView.topAnchor,
                                                 constant: 18),
            middleStackView.leadingAnchor.constraint(equalTo: middleContainerView.leadingAnchor,
                                                     constant: 20),
            middleStackView.trailingAnchor.constraint(equalTo: middleContainerView.trailingAnchor,
                                                      constant: -20),
            middleStackView.bottomAnchor.constraint(equalTo: middleContainerView.bottomAnchor,
                                                    constant: -18),
            surporterStackView.centerXAnchor.constraint(equalTo: surporterView.centerXAnchor),
            surporterStackView.topAnchor.constraint(equalTo: surporterView.topAnchor, constant: 16),
            surporterCountLabel.centerXAnchor.constraint(equalTo: surporterView.centerXAnchor),
            surporterCountLabel.topAnchor.constraint(equalTo: surporterStackView.bottomAnchor,
                                                     constant: 2),
            surporterCountLabel.bottomAnchor.constraint(equalTo: surporterView.bottomAnchor, constant: -14),
            newsStackView.topAnchor.constraint(equalTo: newsView.topAnchor, constant: 16),
            newsStackView.centerXAnchor.constraint(equalTo: newsView.centerXAnchor),
            newsCountLabel.topAnchor.constraint(equalTo: newsStackView.bottomAnchor, constant: 2),
            newsCountLabel.centerXAnchor.constraint(equalTo: newsView.centerXAnchor),
            newsCountLabel.bottomAnchor.constraint(equalTo: newsView.bottomAnchor, constant: -14),
            
            pageControl.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor)
        ])
    }
}

extension FundrasingDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailData.count
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
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x/scrollView.bounds.width)
        pageControl.currentPage = page
    }
}
