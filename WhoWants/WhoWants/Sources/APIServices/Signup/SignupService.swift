//
//  SignupService.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/12/12.
//

import Foundation
import Alamofire

struct SignupParameterDTO: ParameterAble {
    let email: String
    let pw: String
    let name: String
    let phoneNumber: String
    let isAuthorized: String
    
    func makeParameter() -> Parameters {
        return [
            "email": email,
            "pw": pw,
            "name": name,
            "phoneNumber": phoneNumber,
            "isAuthorized": isAuthorized
        ]
    }
}

struct SignupService {
    static let shared = SignupService()
    
    private init() { }
    
    func requestSignup(_ parameter: ParameterAble,
                       completion: @escaping (NetworkResult<Any>) -> Void) {
        let headers: HTTPHeaders = [
            HTTPHeaderKey.contenttype.rawValue : HTTPHeaderValue.ContentTypeValue.json.rawValue
        ]
        
        
        AF.request(APIConstants.signup, method: .post, parameters: parameter.makeParameter(),
                   encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200...500)
            .responseDecodable(of: ResponseData<Int>.self) { response in
                switch response.result {
                case .success(let isSuccess):
                    if isSuccess.status == 201 {
                        completion(.success(isSuccess.message))
                    } else if isSuccess.status == 403 {
                        completion(.requestErr(403))
                    }  else {
                        completion(.serverErr)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    completion(.networkFail)
                }
            }
    }
}
