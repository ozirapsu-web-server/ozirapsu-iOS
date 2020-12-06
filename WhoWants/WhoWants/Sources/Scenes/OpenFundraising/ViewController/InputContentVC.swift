//
//  InputContentVC.swift
//  WhoWants
//
//  Created by 안재은 on 2020/12/04.
//

import UIKit

class InputContentVC: UIViewController {
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var tagUnderline: UIView!
    
    
    private func setContentView() {
        self.contentView.setBorder(borderColor: .graytext, borderWidth: 1)
        self.contentView.makeRounded(cornerRadius: 6)
    }
    
    @objc
    func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func next(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InputImageVC")

        navigationController?.pushViewController(vc!, animated: true)
    }
    
    private func setNav(){
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .mainblack
        navigationItem.title = "모금 개설하기"
        let backbtn = UIBarButtonItem(image: UIImage(named: ImageName.backBtn),
                                      style: .plain,
                                      target: self,
                                      action: #selector(back(_:)))
        backbtn.imageInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = backbtn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentTextView.delegate = self
        /**ERROR: 동적으로 textView height 조절하기*/
        //contentTextView.adjustUITextViewHeight()
        //content view UI setting
        setContentView()
        textViewSetup()
        
        initGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNav()
    }

}

extension InputContentVC: UITextViewDelegate {
    
    //start editing on contentTextView
    func textViewSetup() {
        if contentTextView.text == "어떤 모금 프로젝트를 진행하시나요?" {
            contentTextView.text = ""
            contentTextView.textColor = .mainblack
        } else if contentTextView.text == "" {
            contentTextView.text = "어떤 모금 프로젝트를 진행하시나요?"
            contentTextView.textColor = .graytext
            countLabel.text = ""
            contentView.setBorder(borderColor: .graytext, borderWidth: 1)
        }
    }
    
    //start editing on contentTextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewSetup()
    }
    
    //end editing on contentTextView
    func textViewDidEndEditing(_ textView: UITextView) {
        if contentTextView.text == "" {
            textViewSetup()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        /** ERROR: 지우기 할 때 숫자 제대로 출력되지 않음 */
        if(textView == contentTextView){
            let strLength = textView.text?.count ?? 0
            let lngthToAdd = text.count
            let lengthCount = strLength + lngthToAdd
            
            self.countLabel.textColor = .mainblack
            
            self.contentView.setBorder(borderColor: .mainblack, borderWidth: 1)
            
            self.countLabel.text = "\(lengthCount)" + "/800"
        }
        
//
        return true
    }
}

extension UITextView {
    func adjustUITextViewHeight() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
    }
}


extension InputContentVC: UIGestureRecognizerDelegate {
    
    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        textFieldTap.delegate = self
        view.addGestureRecognizer(textFieldTap)
    }
    
    // 다른 위치 탭했을 때 키보드 없어지는 코드
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
        self.contentTextView.resignFirstResponder()
        self.tagTextField.resignFirstResponder()
    }
    
    
    func gestureRecognizer(_ gestrueRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: contentTextView))! || (touch.view?.isDescendant(of: tagTextField))! {
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
