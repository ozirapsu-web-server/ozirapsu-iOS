//
//  InputContentVC.swift
//  WhoWants
//
//  Created by 안재은 on 2020/12/04.
//

import UIKit

class InputContentVC: UIViewController {
    
    // MARK: - Init
    // 내용 입력
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    // 태크 입력
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var tagUnderline: UIView!
    
    // 버튼
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            self.nextButton.backgroundColor = .graytext
        }
    }
    
    // progress view
    @IBOutlet weak var progressView: UIProgressView! {
        didSet {
        self.progressView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    // constraint
    @IBOutlet weak var keyboardConstraint: NSLayoutConstraint!
    
    
    /** TEST*/
    var fundraising = Fundraising(title: "", targetAmount: 0, contents: "", tagList: [], images: [])
    
    
    // MARK: - Layout
    
    // navigation bar
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
    
    // progress view
    private func setProgressView() {
        self.progressView.setProgress(0.5, animated: true)
        configureLayout()
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    // 내용 입력 뷰
    private func setContentView() {
        self.contentView.setBorder(borderColor: .graytext, borderWidth: 1)
        self.contentView.makeRounded(cornerRadius: 6)
    }
    
    // 태크 입력 textField
    private func setTag() {
        self.tagUnderline.backgroundColor = .mainblack
    }
    
    private func edittedContent() {
        self.countLabel.textColor = .mainblack
        self.contentView.setBorder(borderColor: .mainblack, borderWidth: 1)
    }
    
    private func edittedTag() {
        self.tagUnderline.backgroundColor = .mainblack
    }
    
    // MARK: - Action
    
    func activateNextButton() {
        if contentTextView.text != "" && tagTextField.text != "" {
            self.nextButton.backgroundColor = .mainblack
            self.nextButton.isUserInteractionEnabled = true
        } else {
            self.nextButton.backgroundColor = .graytext
            self.nextButton.isUserInteractionEnabled = false
        }
    }
    
    @objc
    func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func next(_ sender: Any) {
        
        guard let content = self.contentTextView.text else { return }
        
        guard let tags = self.tagTextField.text?.components(separatedBy: ",") else { return }
        
        self.fundraising.contents = content
        self.fundraising.tagList = tags
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InputImageVC") as! InputImageVC
        
        vc.fundraising = self.fundraising
        
        // navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentTextView.delegate = self
        self.tagTextField.delegate = self
        
        /**ERROR: 동적으로 textView height 조절하기*/
        //contentTextView.adjustUITextViewHeight()
        //content view UI setting
        
        initGestureRecognizer()
        setContentView()
        setTextView()
        setProgressView()
        
        /**TEST*/
        print(fundraising)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNav()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }

}

// MARK: - Extension


// textView Delegate
extension InputContentVC: UITextViewDelegate, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        registerForKeyboardNotifications()
        edittedTag()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string != "" {
            edittedTag()
        } else {
            tagUnderline.backgroundColor = .graytext
        }
        return true
    }
    //start editing on contentTextView
    func setTextView() {
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
        setTextView()
    }
    
    //end editing on contentTextView
    func textViewDidEndEditing(_ textView: UITextView) {
        if contentTextView.text == "" {
            setTextView()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if(textView == contentTextView){
            let strLength = textView.text?.count ?? 0
            let lngthToAdd = text.count
            let lengthToReplace = range.length
            let lengthCount = strLength + lngthToAdd - lengthToReplace
            
            edittedContent()
            
            self.countLabel.text = "\(lengthCount)" + "/800"
            
            if lengthCount >= 800 {
                return false
            }
            
        }
        
        if !text.isEmpty {            nextButton.backgroundColor = .mainblack
            nextButton.isUserInteractionEnabled = true
        } else {
            nextButton.backgroundColor = .graytext
            nextButton.isUserInteractionEnabled = false
        }
        
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
            self.keyboardConstraint.constant = -100
            
        })
        
        self.view.layoutIfNeeded()
    }
    
    // keyboard가 사라질 때 어떤 동작을 수행
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            
            self.keyboardConstraint.constant = 36
            
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
