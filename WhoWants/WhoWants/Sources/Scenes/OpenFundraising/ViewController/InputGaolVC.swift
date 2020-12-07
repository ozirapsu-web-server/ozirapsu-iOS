//
//  InputGaolVC.swift
//  WhoWants
//
//  Created by 안재은 on 2020/12/04.
//

import UIKit
import Foundation

/**TEST: 모금 개설 정보 저장 임시 struct*/
struct Fundraising {
    var title : String
    var targetAmount : Int
    var contents : String
    var tagList : [String]
    var images : [UIImage]
    
    init(title: String, targetAmount: Int, contents: String, tagList: [String], images: [UIImage]) {
        self.title = title
        self.targetAmount = targetAmount
        self.contents = contents
        self.tagList = tagList
        self.images = images
    }
}

class InputGaolVC: UIViewController {

    // MARK: - Init
    
    // 목표금액
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountUnderline: UIView!
    
    // 제목
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var titleUnderline: UIView!
    
    // 키보드 constraint
    @IBOutlet weak var fixConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var testConstraint: NSLayoutConstraint!
    
    /**TEST: 모금 개설 정보 저장 배열*/
    var fundraising = Fundraising(title: "", targetAmount: 0, contents: "", tagList: [], images: [])
    
    // 버튼
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.backgroundColor = .graytext
        }
    }
    
    // MARK: - Layout
    // progress view
    /* NAVTEST
    var progressView: UIProgressView = {
        var progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = .whowantsblue
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private func initView() {
        view.addSubview(progressView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    */
    
    // navigation bar
    /*NAVTEST
    private func setNav(){
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .mainblack
        let backbtn = UIBarButtonItem(image: UIImage(named: ImageName.backBtn),
                                      style: .plain,
                                      target: self,
                                      action: #selector(back(_:)))
        backbtn.imageInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = backbtn
    }
     */
    
    // textfield
    private func edittedAmount() {
        self.amountLabel.textColor = .mainblack
        self.amountUnderline.backgroundColor = .mainblack
    }
    
    private func edittedTitle() {
        self.countLabel.textColor = .mainblack
        self.titleUnderline.backgroundColor = .mainblack
    }
    
    // MARK: - Action
    @IBAction func back(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    
    }
    
    var completion: ((String) -> Void)?
    
    @objc
    @IBAction func next(_ sender: Any) {
        completion?(titleTextField.text!)
        
        guard let amount = self.amountTextField.text else { return }
        
        guard let title = self.titleTextField.text else { return }
        
        self.fundraising.targetAmount = Int(amount) ?? 0
        self.fundraising.title = title
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InputContentVC") as! InputContentVC
        
        vc.fundraising = self.fundraising
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountTextField.delegate = self
        titleTextField.delegate = self
        
        initGestureRecognizer()
        
        // NAVTEST
        //self.progressView.setProgress(0.25, animated: true)
        //initView()
        //configureLayout()
        
        nextButton.isUserInteractionEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // NAVTEST
        // setNav()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
}

// MARK: - Extension
extension InputGaolVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == titleTextField {
            registerForKeyboardNotifications()
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == titleTextField {
            
            let strLength = textField.text?.count ?? 0
            let lngthToAdd = string.count
            let lengthToReplace = range.length
            let lengthCount = strLength + lngthToAdd - lengthToReplace
            
            self.countLabel.text = "\(lengthCount)"
            edittedTitle()
            
            // 50자 넘어가는 경우 Case 처리
            if lengthCount >= 50 {
                return false
            }
            
          } else {
            edittedAmount()
          }
        
        //
        if titleTextField.text != "" && amountTextField.text != "" {
            nextButton.backgroundColor = .mainblack
            nextButton.isUserInteractionEnabled = true
        } else {
            nextButton.backgroundColor = .graytext
            nextButton.isUserInteractionEnabled = false
        }
        
          return true
    }
    
}


extension InputGaolVC: UIGestureRecognizerDelegate {
    
    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        textFieldTap.delegate = self
        view.addGestureRecognizer(textFieldTap)
    }
    
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
        self.amountTextField.resignFirstResponder()
        self.titleTextField.resignFirstResponder()
    }
    
    func gestureRecognizer(_ gestrueRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: amountTextField))! || (touch.view?.isDescendant(of: titleTextField))! {
            return false
        }
        return true
    }
    
    // keyboard가 보여질 때 어떤 동작을 수행
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight: CGFloat
        
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        
        // animation
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            
            // +로 갈수록 y값이 내려가고 -로 갈수록 y값이 올라간다.
            self.testConstraint.constant = -36
            // self.fixConstraint.constant = -keyboardHeight/200
        })
        
        self.view.layoutIfNeeded()
    }
    
    // keyboard가 사라질 때 어떤 동작을 수행
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            
            // 원래대로 돌아가도록
            // self.viewYcenter.constant = 125
            
            self.testConstraint.constant = 36
            // self.fixConstraint.constant = 147
        })
        
        self.view.layoutIfNeeded()
    }
    
    
    // observer
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension InputGaolVC: FundraisingInputTable {
    var type: FundraisingInputType {
        return .goal
    }
    
    var transfer: ((String) -> Void)? {
        get {
            return completion
        }
        set {
            completion = newValue
        }
    }
}
