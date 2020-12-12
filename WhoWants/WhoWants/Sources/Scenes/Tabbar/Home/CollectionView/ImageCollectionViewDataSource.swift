//
//  ImageCollectionViewDataSource.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/12/12.
//

import Foundation
import UIKit

class ImageCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var imagesData: [String]
    
    init(_ data: [String]) {
        self.imagesData = data
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let fundraisingImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: FundraisingImageCell.identifier,
                                                                            for: indexPath)
                as? FundraisingImageCell else { return UICollectionViewCell() }
        fundraisingImageCell.bind()
        return fundraisingImageCell
    }
}
