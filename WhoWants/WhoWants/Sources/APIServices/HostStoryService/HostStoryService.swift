//
//  HostStoryService.swift
//  WhoWants
//
//  Created by 윤동민 on 2020/12/13.
//

import Foundation
import Alamofire

struct HostStoryDTO: Codable {
    let count: Int
    let stories: [StoryDTO]
}

struct StoryDTO: Codable {
    let idx: Int
    let title: String
    let image: String
    let amount_rate: Int
    let support_cnt: Int
}

struct HostStoryService {
    static let shared = HostStoryService()
    
    private init() { }
    
    func requestHostStory(_ completion: @escaping (NetworkResult<Any>) -> Void) {
        guard let acccessToken = UserDefaults.standard.object(forKey: UserDefaultsKey.token.rawValue)
                as? String else { return }
        let headers: HTTPHeaders = [
            HTTPHeaderKey.contenttype.rawValue: HTTPHeaderValue.ContentTypeValue.json.rawValue,
            HTTPHeaderKey.jwt.rawValue: acccessToken
        ]
        
        AF.request(APIConstants.hoststory, method: .get, headers: headers)
            .validate(statusCode: 200...500)
            .responseDecodable(of: ResponseData<HostStoryDTO>.self) { response in
                switch response.result {
                case .success(let responseData):
                    if responseData.status == 200 {
                        completion(.success(responseData.data!))
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
