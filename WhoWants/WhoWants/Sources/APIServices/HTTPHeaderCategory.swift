//
//  HTTPHeaderCategory.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/12/12.
//

import Foundation

enum HTTPHeaderKey: String {
    case contenttype = "Content-Type"
    case jwt = "jwt"
}

enum HTTPHeaderValue {
    enum ContentTypeValue: String {
        case json = "Application/json"
        case multipart = "multipart/form-data"
    }
}
