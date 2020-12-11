//
//  OpenService.swift
//  WhoWants
//
//  Created by 안재은 on 2020/12/08.
//

import Foundation
import Alamofire

struct OpenService {
    
    static let shared = OpenService()
    
    func requestOpen(title: String, targetAmount: Int, contents: String, tagList: [String], images: [UIImage], completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = APIConstants.openFundraisingURL
        
        let header: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            
            // 회원가입, 로그인 후 진짜 토큰
            // "jwt": "\(token.string(forKey: "token")!)",
            
            // TEST token
            "jwt": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHgiOjQsImlhdCI6MTYwNzUyODYyNiwiZXhwIjoxNjA4MTMzNDI2LCJpc3MiOiJ3aG93YW50cyJ9.Ix9vBEGpYvs2mFumwMQmRKQaJIYJpZPekFszbKfpadI"
        ]
        
        let parameters : Parameters = [
            "title": title,
            "targetAmount": targetAmount,
            "contents": contents,
            "tagList": tagList,
            "images": images
        ]
        
        AF.upload(multipartFormData: { MultipartFormData in
            
            for (key, value) in parameters {
                
                if key == "tagList" {
                    
                    let count : Int  = tagList.count
                    
                    for i in 0  ..< count {
                        
                        let valueObj = tagList[i]
                        let keyObj = key + "[" + String(i) + "]"
                        
                        MultipartFormData.append(valueObj.data(using: .utf8)!, withName: keyObj)
                    }
                    
                } else if key == "images" {
                    
                    print("======= IMAGE LIST ========")
                    
                    for (index, image) in images.enumerated(){
                        print(index)
                        var imageData = image.jpegData(compressionQuality: 0.6)
                        // print(imageData)
                        MultipartFormData.append(imageData!, withName: key, fileName: "image.png",mimeType: "image/png")
                        // print(imageData)
                        imageData?.removeAll()
                    }
                } else if key == "targetAmount"{
                    
                    MultipartFormData.append("\(value)".data(using: .utf8)!, withName: key as String)
                    
                    print("======= 모금액 ========")
                    print("\(value)".data(using: String.Encoding.utf8)!)
                    
                } else if key == "title" {
                    
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    
                    print("======= 모금 제목 ========")
                    print("\(value)".data(using: String.Encoding.utf8)!)
                    
                } else if key == "contents" {
                    
                    MultipartFormData.append((value as! String).data(using: .utf8)!, withName: key as String)
                    
                    print("======= 모금 내용 ========")
                    print("\(value)".data(using: String.Encoding.utf8)!)
                    
                }
                
            }
            
        }, to: url, method: .post, headers: header).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {
                    return
                }
                
                guard let data = response.value else {
                    return
                }
                
                switch statusCode {
                case 200, 201:
                    
                    let decoder = JSONDecoder()
                    
                    guard let decodedData = try? decoder.decode(ResponseObject.self, from: data)
                        else {
                            completion(.pathErr)
                            return
                    }
                    
                    let datas = decodedData.data.storyURL
                    
                    completion(.success(datas))
                    
                
                case 400..<500:
                    completion(.requestErr("requestErr"))
                    
                default:
                    completion(.pathErr)
                }
                
                break
                
            // 통신 실패 - 네트워크 연결
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
                // .networkFail이라는 반환 값이 넘어감
                break
            }
        }
    }
}
