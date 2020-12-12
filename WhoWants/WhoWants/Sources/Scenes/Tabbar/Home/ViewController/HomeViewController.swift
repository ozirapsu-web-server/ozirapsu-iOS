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
    case emptyTitle = "아직 개설한 프로젝트가 없네요"
    case emptySubTitle = "돕고 싶은 사연이 있나요?\n후원츠와 함께 더 나은 세상을 만들어봐요!"
    case makeBtn = "모금함 개설하기"
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
        collectionView.contentInset = UIEdgeInsets(top: view.safeAreaInsets.top,
                                                   left: 0,
                                                   bottom: 50,
                                                   right: 0)
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
    
    let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageName.empty_fundraising)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let emptyTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: HomeText.emptyTitle.rawValue,
                                                  attributes: [.font: UIFont(name: FontName.notosans_bold,
                                                                             size: 20)!,
                                                               .kern: -0.8,
                                                               .foregroundColor: UIColor.mainblack])
        return label
    }()
    
    let emptySubTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        let attributeText = NSMutableAttributedString(string: HomeText.emptySubTitle.rawValue,
                                               attributes: [.font: UIFont(name: FontName.notosans_regular,
                                                                          size: 12)!,
                                                            .foregroundColor: UIColor(red: 0.741,
                                                                                      green: 0.741,
                                                                                      blue: 0.741,
                                                                                      alpha: 1.0),
                                                            .paragraphStyle: paragraphStyle])
        label.attributedText = attributeText
        return label
    }()
    
    let makeButton: UIButton = {
        let btn = UIButton(type: .system)
        let attributeText = NSAttributedString(string: HomeText.makeBtn.rawValue,
                                               attributes: [.font: UIFont(name: FontName.notosans_medium,
                                                                          size: 16)!,
                                                            .kern: -0.64,
                                                            .foregroundColor: UIColor.white])
        btn.setAttributedTitle(attributeText, for: .normal)
        btn.backgroundColor = .whowantsblue
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - Init
    private func initView() {
        self.view.addSubview(homeCollectionView)
        self.view.addSubview(emptyView)
        emptyView.addSubview(emptyImageView)
        emptyView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(emptyTitleLabel)
        labelStackView.addArrangedSubview(emptySubTitleLabel)
        emptyView.addSubview(makeButton)
    }
    
    private func setNav() {
        let logoImage = UIImageView(image: UIImage(named: ImageName.logo))
        logoImage.contentMode = .scaleAspectFit
        navigationItem.titleView = logoImage
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - Data
    private var hostStoryDTO: HostStoryDTO = HostStoryDTO(count: 0, stories: []) {
        didSet {
            DispatchQueue.main.async {
                self.emptyView.isHidden = self.hostStoryDTO.count == 0 ? false : true
                self.homeCollectionView.reloadData()
            }
        }
    }
    
    // MARK: - Action
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + self.view.safeAreaInsets.top
        let alpha = 1 - (((offset)*2) / self.view.safeAreaInsets.top)
        
        navigationItem.titleView?.alpha = max(0, alpha)
        navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: min(0, -offset))
    }
    
    private func requestHostStory() {
        HostStoryService.shared.requestHostStory { [weak self] result in
            switch result {
            case .success(let storyData):
                print("success")
                guard let storyData = storyData as? HostStoryDTO else { return }
                self?.hostStoryDTO = storyData
            case .serverErr:
                print("Server Err")
            case .networkFail:
                print("Network Err")
            default:
                return
            }
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        
        configureLayout()
        
        requestHostStory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNav()
    }
    
    // MARK: - Layout
    private func configureLayout() {
        let cornerRadius = (self.view.frame.width - 20*2)/55
        makeButton.layer.cornerRadius = cornerRadius
        
        let topContant = (self.view.bounds.width*0.17) + 41
        
        NSLayoutConstraint.activate([
            homeCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            homeCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            emptyView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            emptyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            emptyView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                           constant: topContant),
            labelStackView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            labelStackView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyImageView.bottomAnchor.constraint(equalTo: labelStackView.topAnchor, constant: -30),
            makeButton.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 36),
            makeButton.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 20),
            makeButton.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -20),
            makeButton.heightAnchor.constraint(equalTo: makeButton.widthAnchor, multiplier: 0.14)
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
        else { return hostStoryDTO.count }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // FIXME: 셀 들어갈 모델 결정되면 Cell Model 데이터 추상화하기
        guard let fundraseCell = collectionView
                .dequeueReusableCell(withReuseIdentifier: FundraisingCell.identifier,
                                     for: indexPath) as? FundraisingCell else {
            return UICollectionViewCell()
        }
        
        let storyDTO = hostStoryDTO.stories[indexPath.row]
        
        fundraseCell.setFundraisingCell(FundraisingCellDTO(image: storyDTO.image,
                                                           title: storyDTO.title,
                                                           count: storyDTO.support_cnt,
                                                           percent: storyDTO.amount_rate*10))
        
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
            
            reusableCurView.setHeader(hostStoryDTO.count)
            
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
        if indexPath.section == 0 { return }
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

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = FundrasingDetailViewController()
        detailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
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
