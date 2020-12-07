//
//  uploadImageCVC.swift
//  WhoWants
//
//  Created by 안재은 on 2020/12/06.
//

import UIKit

class uploadImageCVC: UICollectionViewCell {
    
    @IBOutlet weak var thumImg: UIImageView!
    
    @IBOutlet weak var blurView: UIView!
    
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        titleView.backgroundColor = .clear
        titleView.makeRounded(cornerRadius: 7)
        titleView.setBorder(borderColor: .white, borderWidth: 1)
        
    }
    
}
