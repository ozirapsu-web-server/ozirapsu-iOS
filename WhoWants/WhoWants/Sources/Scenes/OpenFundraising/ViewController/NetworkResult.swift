//
//  NetworkResult.swift
//  WhoWants
//
//  Created by 안재은 on 2020/12/08.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
    case dbErr
}
