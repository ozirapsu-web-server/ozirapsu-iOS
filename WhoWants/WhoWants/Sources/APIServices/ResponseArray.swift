//
//  ResponseArray.swift
//  WhoWants
//
//  Created by 안재은 on 2020/12/11.
//

import Foundation

struct ResponseObject: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let storyURL: String
}
