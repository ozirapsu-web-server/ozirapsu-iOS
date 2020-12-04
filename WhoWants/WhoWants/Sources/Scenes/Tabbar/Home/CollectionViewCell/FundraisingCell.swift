//
//  FundraisingCell.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/12/04.
//

import UIKit

class FundraisingCell: UICollectionViewCell {
    static let identifier = "FundaisingCell"
    
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
