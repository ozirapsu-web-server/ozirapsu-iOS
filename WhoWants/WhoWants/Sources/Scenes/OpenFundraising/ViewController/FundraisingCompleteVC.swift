//
//  FundraisingCompleteVC.swift
//  WhoWants
//
//  Created by 안재은 on 2020/12/04.
//

import UIKit


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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }

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
