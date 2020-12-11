//
//  SigninService.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/12/12.
//

import Foundation
import Alamofire

struct SigninParameterDTO: ParameterAble {
    let email: String
    let pw: String
    
    func makeParameter() -> Parameters {
        return [
            "email": email,
            "pw": pw
        ]
    }
}
 
struct SigninService {
    static let shared = SigninService()
    
    private init() { }

    func reqeustSignin(_ parameter: ParameterAble,
                       completion: @escaping (NetworkResult<Any>) -> Void) {
        let headers: HTTPHeaders = [
            HTTPHeaderKey.contenttype.rawValue: HTTPHeaderValue.ContentTypeValue.json.rawValue
        ]
        
        AF.request(APIConstants.signin, method: .post, parameters: parameter.makeParameter(),
                   encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200...500)
            .responseDecodable(of: ResponseData<Int>.self) { response in
                switch response.result {
                case .success(let signinData):
                    if signinData.status == 200 {
                        guard let token = response.response?.headers[UserDefaultsKey.token.rawValue],
                              let refreshToken = response.response?.headers[UserDefaultsKey.refreshToken.rawValue]
                        else { return }
                        UserDefaults.standard.setValue(token, forKey: UserDefaultsKey.token.rawValue)
                        UserDefaults.standard.setValue(refreshToken, forKey: UserDefaultsKey.refreshToken.rawValue)
                        completion(.success(signinData.success))
                    } else if signinData.status == 400 {
                        completion(.requestErr(signinData.message))
                    } else {
                        completion(.serverErr)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    completion(.networkFail)
                }
            }
    }
}
