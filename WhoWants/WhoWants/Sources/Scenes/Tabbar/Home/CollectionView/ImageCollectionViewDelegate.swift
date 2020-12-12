//
//  ImageCollectionViewDelegate.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/12/12.
//

import UIKit

class ImageCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    var imagesData: [String]
    
    // MARK: - Action
    var endScroll: ((Int) -> Void)?
    
    // MARK: - Life Cycle
    init(_ imageData: [String]) {
        self.imagesData = imageData
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x/scrollView.bounds.width)
        endScroll?(page)
    }
}
