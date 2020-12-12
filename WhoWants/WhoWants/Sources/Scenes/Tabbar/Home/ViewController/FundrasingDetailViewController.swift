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
    case progress = "진행중"
    case curMoney = "모인 금액"
    case totalMoney = "목표 금액"
    case shareBtn = "모금함 공유하기"
    case tip = "3명의 친구에게 SNS 공유를 부탁하면 모금 성공 확률이 250% 상승 효과가 있습니다. 사연을 공유해주세요! 💪"
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
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        uiView.translatesAutoresizingMaskIntoConstraints = false
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
        collectionView.dataSource = imageCollectionViewDataSource
        collectionView.delegate = imageCollectionViewDelegate
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var imageCollectionViewDataSource = ImageCollectionViewDataSource(["Hi", "Hi", "Hi", "Hi", "Hi"])
    var imageCollectionViewDelegate = ImageCollectionViewDelegate(["Hi", "Hi", "Hi", "Hi", "Hi"])
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    let middleContainerView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1.0)
        uiView.translatesAutoresizingMaskIntoConstraints = false
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
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
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
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
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
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
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
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stateView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .white
        uiView.clipsToBounds = true
        return uiView
    }()
    
    let percentLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "10%",
                                                  attributes: [.font: UIFont(name: FontName.notosans_bold,
                                                                             size: 20)!,
                                                               .kern: -0.8,
                                                               .foregroundColor: UIColor.whowantsblue])
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: FundrasingDetailText.progress.rawValue,
                                                  attributes: [.font: UIFont(name: FontName.notosans_medium,
                                                                             size: 14)!,
                                                               .kern: -0.56,
                                                               .foregroundColor: UIColor.mainblack])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = .whowantsblue
        progressView.setProgress(0.1, animated: true)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    let moneyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let curMoneyContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let curMoneyStateLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: FundrasingDetailText.curMoney.rawValue,
                                                  attributes: [.font: UIFont(name: FontName.notosans_regular,
                                                                             size: 12)!,
                                                               .kern: -0.48,
                                                               .foregroundColor: UIColor.mainblack])
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let curMoneyAmountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = 10000.convertUnitKR() + " 원"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalMoneyContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let totalMoneyStateLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: FundrasingDetailText.totalMoney.rawValue,
                                                  attributes: [.font: UIFont(name: FontName.notosans_regular,
                                                                             size: 12)!,
                                                               .kern: -0.48,
                                                               .foregroundColor: UIColor.mainblack])
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalMoneyAmountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = 1000.convertUnitKR() + " 원"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bottomContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let shareButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .whowantsblue
        let attributeText = NSAttributedString(string: FundrasingDetailText.shareBtn.rawValue,
                                               attributes: [.font: UIFont(name: FontName.notosans_medium,
                                                                          size: 16)!,
                                                            .kern: -0.64,
                                                            .foregroundColor: UIColor.white])
        btn.setAttributedTitle(attributeText, for: .normal)
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let tipView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1.0)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tipLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        let attributeText = NSMutableAttributedString(string: FundrasingDetailText.tip.rawValue,
                                                      attributes: [.font: UIFont(name: FontName.notosans_light,
                                                                                 size: 12)!,
                                                                   .kern: -0.48,
                                                                   .foregroundColor: UIColor.mainblack])
        
        attributeText.addAttribute(.font, value: UIFont(name: FontName.notosans_medium, size: 12)!,
                                   range: (FundrasingDetailText.tip.rawValue as NSString).range(of: "250% 상승 효과"))
        label.attributedText = attributeText
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cheerAdminView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // FIXME: CollectionView을 따로 빼기
    lazy var cheerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cellWidth = UIScreen.main.bounds.width - 20*2
        let height = cellWidth
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: cellWidth, height: 90)
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CheerCollectionViewCell.self,
                                forCellWithReuseIdentifier: CheerCollectionViewCell.identifier)
        collectionView.dataSource = cheerCollectionViewDataSource
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var cheerCollectionViewHeightConstraint: NSLayoutConstraint!
    
    var cheerCollectionViewDataSource = CheerCollectionViewDataSource(["Hi", "Hi", "Hi"])
    
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
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func initView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
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
        
        middleStackView.addArrangedSubview(stateView)
        stateView.addSubview(percentLabel)
        stateView.addSubview(progressLabel)
        stateView.addSubview(progressView)
        stateView.addSubview(moneyStackView)
        moneyStackView.addArrangedSubview(curMoneyContainerView)
        moneyStackView.addArrangedSubview(totalMoneyContainerView)
        curMoneyContainerView.addSubview(curMoneyStateLabel)
        curMoneyContainerView.addSubview(curMoneyAmountLabel)
        totalMoneyContainerView.addSubview(totalMoneyStateLabel)
        totalMoneyContainerView.addSubview(totalMoneyAmountLabel)
        
        contentStackView.addArrangedSubview(bottomContainerView)
        bottomContainerView.addSubview(shareButton)
        bottomContainerView.addSubview(tipView)
        tipView.addSubview(tipLabel)
        
        bottomContainerView.addSubview(cheerAdminView)
        cheerAdminView.addSubview(cheerCollectionView)
        
        pageControl.numberOfPages = detailData.count
    }
    
    private func configureDelegate() {
        imageCollectionViewDelegate.endScroll = { [weak self] page in
            self?.pageControl.currentPage = page
        }
    }
    
    // MARK: - Data
    
    /* 데이터 나중에 Class 타입으로 바꾸고 설정되었을 때, reload 수행할 수 있게 */
    var detailData = ["Hi", "Hi", "Hi", "Hi", "Hi"]
    
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
        configureDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Layout
    private func configureLayout() {
        let stateViewCorner: CGFloat = (self.view.bounds.width - 20*2 - 7)/2/27
        surporterView.layer.cornerRadius = stateViewCorner
        newsView.layer.cornerRadius = stateViewCorner
        stateView.layer.cornerRadius = stateViewCorner
        shareButton.layer.cornerRadius = stateViewCorner
        tipView.layer.cornerRadius = stateViewCorner
        
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(rawValue: 750)
        
        cheerCollectionViewHeightConstraint = cheerCollectionView.heightAnchor.constraint(equalToConstant: 0)
        cheerCollectionViewHeightConstraint.priority = UILayoutPriority(rawValue: 500)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            heightConstraint,
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
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
            
            percentLabel.topAnchor.constraint(equalTo: stateView.topAnchor, constant: 10),
            percentLabel.leadingAnchor.constraint(equalTo: stateView.leadingAnchor, constant: 18),
            progressLabel.leadingAnchor.constraint(equalTo: percentLabel.trailingAnchor, constant: 7),
            progressLabel.centerYAnchor.constraint(equalTo: percentLabel.centerYAnchor),
            progressView.topAnchor.constraint(equalTo: percentLabel.bottomAnchor, constant: 5),
            progressView.leadingAnchor.constraint(equalTo: stateView.leadingAnchor, constant: 18),
            progressView.trailingAnchor.constraint(equalTo: stateView.trailingAnchor, constant: -18),
            progressView.heightAnchor.constraint(equalToConstant: 6),
            moneyStackView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 8),
            moneyStackView.leadingAnchor.constraint(equalTo: progressView.leadingAnchor),
            moneyStackView.trailingAnchor.constraint(equalTo: progressView.trailingAnchor),
            moneyStackView.bottomAnchor.constraint(equalTo: stateView.bottomAnchor, constant: -12),
            
            curMoneyStateLabel.leadingAnchor.constraint(equalTo: curMoneyContainerView.leadingAnchor),
            curMoneyStateLabel.topAnchor.constraint(equalTo: curMoneyContainerView.topAnchor),
            curMoneyStateLabel.bottomAnchor.constraint(equalTo: curMoneyContainerView.bottomAnchor),
            
            curMoneyAmountLabel.leadingAnchor.constraint(equalTo: curMoneyStateLabel.trailingAnchor,
                                                         constant: 10),
            curMoneyAmountLabel.centerYAnchor.constraint(equalTo: curMoneyStateLabel.centerYAnchor),
            curMoneyAmountLabel.trailingAnchor.constraint(equalTo: curMoneyContainerView.trailingAnchor),
            
            totalMoneyStateLabel.leadingAnchor.constraint(equalTo: totalMoneyContainerView.leadingAnchor),
            totalMoneyStateLabel.topAnchor.constraint(equalTo: totalMoneyContainerView.topAnchor),
            totalMoneyStateLabel.bottomAnchor.constraint(equalTo: totalMoneyContainerView.bottomAnchor),
            totalMoneyAmountLabel.leadingAnchor.constraint(equalTo: totalMoneyStateLabel.trailingAnchor, constant: 10),
            totalMoneyAmountLabel.centerYAnchor.constraint(equalTo: totalMoneyStateLabel.centerYAnchor),
            totalMoneyAmountLabel.trailingAnchor.constraint(equalTo: totalMoneyContainerView.trailingAnchor),
            
            shareButton.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 24),
            shareButton.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 20),
            shareButton.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -20),
            shareButton.heightAnchor.constraint(equalTo: shareButton.widthAnchor, multiplier: 0.14),
            tipView.topAnchor.constraint(equalTo: shareButton.bottomAnchor, constant: 12),
            tipView.leadingAnchor.constraint(equalTo: shareButton.leadingAnchor),
            tipView.trailingAnchor.constraint(equalTo: shareButton.trailingAnchor),
            tipLabel.topAnchor.constraint(equalTo: tipView.topAnchor, constant: 6),
            tipLabel.leadingAnchor.constraint(equalTo: tipView.leadingAnchor, constant: 12),
            tipLabel.trailingAnchor.constraint(equalTo: tipView.trailingAnchor, constant: -12),
            tipLabel.bottomAnchor.constraint(equalTo: tipView.bottomAnchor, constant: -6),
            
            cheerAdminView.topAnchor.constraint(equalTo: tipView.bottomAnchor, constant: 34),
            cheerAdminView.leadingAnchor.constraint(equalTo: tipView.leadingAnchor),
            cheerAdminView.trailingAnchor.constraint(equalTo: tipView.trailingAnchor),
            cheerCollectionView.leadingAnchor.constraint(equalTo: cheerAdminView.leadingAnchor),
            cheerCollectionView.topAnchor.constraint(equalTo: cheerAdminView.topAnchor),
            cheerCollectionView.trailingAnchor.constraint(equalTo: cheerAdminView.trailingAnchor),
            cheerCollectionView.bottomAnchor.constraint(equalTo: cheerAdminView.bottomAnchor),
            cheerAdminView.bottomAnchor.constraint(lessThanOrEqualTo: bottomContainerView.bottomAnchor,
                                                   constant: -10),
            cheerCollectionViewHeightConstraint,
            
            pageControl.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor)
        ])
        
        let middleSize =
            middleContainerView.systemLayoutSizeFitting(CGSize(width: view.frame.width, height: 200),
                                                        withHorizontalFittingPriority: .required,
                                                        verticalFittingPriority: .fittingSizeLevel)
        middleContainerView.heightAnchor.constraint(equalToConstant: middleSize.height).isActive = true
    }
}
