//
//  CheerCollectionViewDataSource.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/12/12.
//

import UIKit

class CheerCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var cheerData: [String] = ["Hi", "Hi", "Hi"]
    
    init(_ cheerData: [String]) {
        self.cheerData = cheerData
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cheerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cheerCell = collectionView.dequeueReusableCell(withReuseIdentifier: CheerCollectionViewCell.identifier,
                                                                 for: indexPath)
                as? CheerCollectionViewCell else { return UICollectionViewCell() }
        
        cheerCell.bind(CheerCellDTO(nickname: "잰쟁재은",
                                    amount: 20000,
                                    message: "응원합니다..",
                                    timestamp: ""))
        
        return cheerCell
    }
}
