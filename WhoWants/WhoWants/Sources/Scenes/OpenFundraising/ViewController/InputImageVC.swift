//
//  InputImageVC.swift
//  WhoWants
//
//  Created by 안재은 on 2020/12/04.
//

import UIKit
import Photos
import BSImagePicker

class InputImageVC: UIViewController {
    
    // MARK: - Init
    
    /**TEST*/
    var fundraising = Fundraising(title: "", targetAmount: 0, contents: "", tagList: [], images: [])
    
    // 버튼
    @IBOutlet weak var nextButton: UIButton!
    
    // progress view
    @IBOutlet weak var progressView: UIProgressView! {
        didSet{
            self.progressView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    // image 괸련
    @IBOutlet weak var imageCollectionView: UICollectionView!
    var SelectedAssets = [PHAsset]()
    var photoArray = [UIImage]()
    
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
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imageCollectionView.isHidden = true
        
        setNav()
        
        self.progressView.setProgress(0.75, animated: true)
        configureLayout()
        
        
        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        /**TEST*/
        print(fundraising)
    }
    
    // MARK: - Action
    @objc
    func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func next(_ sender: Any) {
        
        /* 통신 세팅
        RequestService.shared.requestProduct() { data in
            switch data {
                
            case .success :
                print("모금함 개설 성공")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "InputContentVC")
                navigationController?.pushViewController(vc!, animated: true)
                
            case .requestErr(let msg):
                print("getCurrentTakingList")
                print(msg)
            case .pathErr:
                print("getCurrentTakingList path err")
            case .serverErr:
                print("getCurrentTakingList server err")
            case .networkFail:
                print("getCurrentTakingList network err")
            case .dbErr:
                print("getCurrentTakingList db err")
            }
        }
        */
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FundraisingCompleteVC") as! FundraisingCompleteVC
        
        vc.fundraising = self.fundraising
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @objc
    @IBAction func selectImage(_ sender: Any) {
        
        let vc = BSImagePickerViewController()
        self.bs_presentImagePickerController(vc, animated: true,
        select: { (assest: PHAsset) -> Void in },
        deselect: { (assest: PHAsset) -> Void in },
        cancel: { (assest: [PHAsset]) -> Void in },
        finish: { (assest: [PHAsset]) -> Void in
            for i in 0..<assest.count {
                self.SelectedAssets.append(assest[i])
            }
        self.convertAssetToImages() }, completion: nil)
        
    }
    
    @objc func addImage(_ sender: Any) {
        let vc = BSImagePickerViewController()
        self.bs_presentImagePickerController(vc, animated: true,
        select: { (assest: PHAsset) -> Void in },
        deselect: { (assest: PHAsset) -> Void in },
        cancel: { (assest: [PHAsset]) -> Void in },
        finish: { (assest: [PHAsset]) -> Void in
            for i in 0..<assest.count {
                self.SelectedAssets.append(assest[i])
            }
        self.convertAssetToImages() }, completion: nil)
    }
    
}

// MARK: - Extension

extension InputImageVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photoArray.count + 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let buttonCell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "addImageCVC", for: indexPath) as! addImageCVC
        
        let imageCell = imageCollectionView.dequeueReusableCell( withReuseIdentifier: "uploadImageCVC", for: indexPath) as! uploadImageCVC
        
        if indexPath.row == 0 {
            
            buttonCell.addImage.addTarget(self, action: #selector(addImage(_:)), for: .touchUpInside)
            
            buttonCell.makeRounded(cornerRadius: 4)
            
            return buttonCell
        
        } else {
            
            imageCell.thumImg.image = photoArray[indexPath.row - 1]
            
            imageCell.makeRounded(cornerRadius: 4)
            
            imageCell.deleteButton.tag = indexPath.row - 1
            
            imageCell.deleteButton.addTarget(self, action: #selector(cancelButtonAction(sender:)), for: .touchUpInside)
            
            if indexPath.row == 1 {
                imageCell.blurView.isHidden = false
            }
            
            
            
            return imageCell
        }
    }
}


extension InputImageVC {
    
    @objc func cancelButtonAction(sender: UIButton) {
        imageCollectionView.deleteItems(at: [IndexPath.init(row: sender.tag, section: 0)])
        photoArray.remove(at: sender.tag)

        if photoArray.count == 0 {
            imageCollectionView.isHidden = true
            nextButton.backgroundColor = .graytext
            nextButton.isUserInteractionEnabled = false
        }
        
        self.fundraising.images = photoArray
    }
    
    func convertAssetToImages() -> Void {

        if SelectedAssets.count != 0 {

            for i in 0..<SelectedAssets.count{

                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()

                var thumbnail = UIImage()

                option.isSynchronous = true

                manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: option, resultHandler: {(result,info) -> Void in
                    thumbnail = result!
                })

                let data = thumbnail.jpegData(compressionQuality: 0.7)
                let newImage = UIImage(data: data!)
                self.photoArray.append(newImage! as UIImage)

            }
            
            print("등록한 사진 개수: " + String(photoArray.count))
            
            if photoArray.count == 0 {
                imageCollectionView.isHidden = true
                
                nextButton.backgroundColor = .graytext
                nextButton.isUserInteractionEnabled = false

            } else {
                
                nextButton.backgroundColor = .mainblack
                nextButton.isUserInteractionEnabled = true
                
                let photos = self.photoArray
                self.fundraising.images = photos
                
                imageCollectionView.isHidden = false
            }
            
            imageCollectionView.reloadData()
            
        }

    }
    
}
