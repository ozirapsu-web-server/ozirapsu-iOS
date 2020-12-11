//
//  Int+Extension.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/12/12.
//

import Foundation

extension Int {
    func convertUnitKR() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
