//
//  APIConstants.swift
//  WhoWants
//
//  Created by 안재은 on 2020/12/08.
//

import Foundation

struct APIConstants {
    static let BaseURL = "http://13.209.249.225:3000"
    
    /* 모금함 개설 */
    static let openFundraisingURL = BaseURL + "/story"
    
    /* 호스트 */
    static let host = BaseURL + "/host"
    static var signup: String {
        return host + "/signup"
    }
    
    static var signin: String {
        return host + "/signin"
    }
    
    static var hoststory: String {
        return host + "/story"
    }
}
