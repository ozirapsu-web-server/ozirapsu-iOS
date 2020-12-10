//
//  FundraisingCompleteVC.swift
//  WhoWants
//
//  Created by 안재은 on 2020/12/04.
//

import UIKit
import Lottie

// MARK: - Protocol
protocol CustomActivityDelegate : NSObjectProtocol {

    func performActionCompletion(actvity: CustomActivity)

}
class CustomActivity: UIActivity {
    
    weak var delegate: CustomActivityDelegate?
    
    override class var activityCategory: UIActivity.Category {
        return .action
    }
    
    override var activityType: UIActivity.ActivityType? {
        guard let bundleId = Bundle.main.bundleIdentifier else {return nil}

        return UIActivity.ActivityType(rawValue: bundleId + "\(self.classForCoder)")
    }

    override var activityTitle: String? {
        return "Open in Safari"
    }

    override var activityImage: UIImage? {
        return UIImage(named : "icons8-safari-50")
    }

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }

    override func prepare(withActivityItems activityItems: [Any]) {

    }

    override func perform() {
        self.delegate?.performActionCompletion(actvity: self)
        activityDidFinish(true)
    }
}

let strURL = "https://www.notion.so/1-Value-Proposition-5e646c3b8e344db4b1b0481f8b12e6bf"

class FundraisingCompleteVC: UIViewController {
    // MARK: - Init
    
    /**TEST*/
    var fundraising = Fundraising(title: "", targetAmount: 0, contents: "", tagList: [], images: [])
    
    @IBOutlet weak var settingView: UIView!
    
    func setAnimation() {
        let animationView = AnimationView(name: "200")
        
        settingView.addSubview(animationView)
        
        animationView.contentMode = .scaleAspectFill
        
        animationView.frame = settingView.bounds
        
        // animationView.frame = CGRect(x: 0, y: 0, width: 250, height: 246)
        
        animationView.play(fromProgress: 0, toProgress: 0.8, loopMode: .none, completion: nil)
        // animationView.play()

    }
    
    @IBOutlet weak var progressView: UIProgressView! {
        didSet {
            self.progressView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
        setAnimation()
        self.progressView.setProgress(1, animated: true)
        
        UIView.animate(withDuration: 1) { () -> Void in
            self.progressView.alpha = 0.0
        }
        
        configureLayout()
        
        /**TEST*/
        print(fundraising)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    // MARK: - Layout
    private func setNav(){
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .mainblack
        navigationItem.title = "모금 개설하기"
        let backbtn = UIBarButtonItem(image: UIImage(named: ""),
                                      style: .plain,
                                      target: self,
                                      action: nil)
        navigationItem.leftBarButtonItem = backbtn
        
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Action
    @IBAction func share(_ sender: Any) {
        
        let customActivity = CustomActivity()
        
        let objectsToShare = strURL
        
        let activityVC = UIActivityViewController(activityItems: [objectsToShare], applicationActivities: [customActivity])
        activityVC.popoverPresentationController?.sourceView = self.view
        
        
        //공유하기 기능 중 제외할 기능이 있을 때 사용
        //activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func finish(_ sender: Any) {
        let tabbarVC = UIStoryboard(name: "Tabbar", bundle: nil)
                .instantiateViewController(withIdentifier: MainTabbarViewController.identifier)
        UIApplication.shared.windows.filter { $0.isKeyWindow }
            .first?.rootViewController = tabbarVC
    }
    
    func performActionCompletion(actvity: CustomActivity) {

        guard let url = NSURL(string: strURL), UIApplication.shared.canOpenURL(url as URL) else { return }

        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)

    }
}
