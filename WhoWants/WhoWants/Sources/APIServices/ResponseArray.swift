//
//  ResponseArray.swift
//  WhoWants
//
//  Created by 안재은 on 2020/12/11.
//

import Foundation
import Alamofire

protocol ParameterAble {
    func makeParameter() -> Parameters
}

struct ResponseData<T: Codable>: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case status
        case success
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? 0
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
    }
}
