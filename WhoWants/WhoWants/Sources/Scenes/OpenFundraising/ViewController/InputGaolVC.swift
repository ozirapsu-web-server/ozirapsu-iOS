//
//  InputGaolVC.swift
//  WhoWants
//
//  Created by 안재은 on 2020/12/04.
//

import UIKit

class InputGaolVC: UIViewController {

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var fixConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var amountUnderline: UIView!
    @IBOutlet weak var titleUnderline: UIView!
    
    var progressView: UIProgressView = {
        var progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = .whowantsblue
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
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
    
    
    @IBAction func back(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    
    }
    
    @IBAction func next(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InputContentVC")

        navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountTextField.delegate = self
        titleTextField.delegate = self
        
        initGestureRecognizer()
        
        self.progressView.setProgress(0.25, animated: true)
        
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNav()
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

extension InputGaolVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          if(textField == titleTextField){
             let strLength = textField.text?.count ?? 0
             let lngthToAdd = string.count
             let lengthCount = strLength + lngthToAdd
            self.countLabel.textColor = .mainblack
            self.titleUnderline.backgroundColor = .mainblack
            if lngthToAdd == 0 {
                self.countLabel.text = "0"
            } else {
                self.countLabel.text = "\(lengthCount)"
            }
          } else {
            self.amountLabel.textColor = .mainblack
            self.amountUnderline.backgroundColor = .mainblack
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
    
    // 다른 위치 탭했을 때 키보드 없어지는 코드
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
            
            self.fixConstraint.constant = -keyboardHeight/60
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
            self.fixConstraint.constant = 147
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
