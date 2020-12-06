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
    
    var SelectedAssets = [PHAsset]()
    var photoArray = [UIImage]()
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imageCollectionView.isHidden = true
        
        setNav()
        
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
    
    @objc
    func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func next(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FundraisingCompleteVC")
        
        navigationController?.pushViewController(vc!, animated: true)
        
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
}

extension InputImageVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photoArray.count + 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let buttonCell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "addImageCVC", for: indexPath) as! addImageCVC
        
        let imageCell = imageCollectionView.dequeueReusableCell( withReuseIdentifier: "uploadImageCVC", for: indexPath) as! uploadImageCVC
        
        if indexPath.row == 0 {
            
            buttonCell.addImage.addTarget(self, action: #selector(selectImage(_:)), for: .touchUpInside)
            
            return buttonCell
        
        } else {
            
            imageCell.thumImg.image = photoArray[indexPath.row - 1]
            
            if indexPath.row != 1 {
                imageCell.blurView.isHidden = true
            }
            return imageCell
        }
    }
}


extension InputImageVC {
    
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
            } else {
                imageCollectionView.isHidden = false
                imageCollectionView.dataSource = self
                imageCollectionView.reloadData()
            }
            
        }

    }
    
}
