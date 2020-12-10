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
    
    func requestOpen(title: String, targetAmount: Int, contents: String, tagList: [String], images: Data, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = APIConstants.openFundraisingURL
        
        // let imageData = image.jpegData(compressionQuality: 0.50)
        
        let header: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
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
                    let arrData =  try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    MultipartFormData.append(arrData, withName: key as String)
                    
                    print("======= TAG LIST ========")
                    print(MultipartFormData.append(arrData, withName: key as String))
                    
                } else if key == "images" {
                    
                    print("======= IMAGE LIST ========")
                    let imageData = UIImage(named: "logo")?.jpegData(compressionQuality: 0.6)
                    MultipartFormData.append(imageData!, withName: key, fileName: "\(title).png",mimeType: "image/png")
                    print(images)
                    
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
                
                switch statusCode {
                case 200, 201:
                    completion(.success("Success"))
                
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
    
    /*
     func requestIdentify(userName: String, imgData: Data, completion: @escaping (DataResponse<HttpStatusCode>) -> Void) {
     
     var urlComponent = APIConstants.openFundraisingURL
     
     let header: [String: String] = [
     "Content-Type": "multipart/form-data"
     ]
     let parameters = [
     "userName" : userName
     ]
     
     AF.upload(multipartFormData: MultipartFormData in {
     
     },
     to: urlComponent, method: .post, headers: header)
     
     Alamofire.UploadRequest(MultipartFormData: { MultipartFormData in
     
     })
     
     Alamofire.upload(multipartFormData: { multipartFormData in
     for (key, value) in parameters {
     multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
     }
     
     multipartFormData.append(imgData, withName: "img", fileName: "\(userName).jpg", mimeType: "image/jpg")
     }, to: urlComponent, method: .post, headers: header) { result in
     switch result {
     case .success(let upload, _, _):
     upload.responseJSON { response in
     print(response)
     guard let data = response.data else { return }
     if let decodedData = try? JSONDecoder().decode(ResponseSimple<Int>.self, from: data) {
     print(decodedData)
     guard let httpStatusCode = HttpStatusCode(rawValue: decodedData.statusCode) else {
     completion(.failed(NSError(domain: "status error",
     code: 0, userInfo: nil)))
     return
     }
     completion(.success(httpStatusCode))
     
     } else { completion(.failed(NSError(domain: "decode error",
     code: 0,
     userInfo: nil)))
     return
     
     }
     
     }
     case .failure(let err):
     completion(.failed(err))
     
     }
     
     }
     
     }
     */
}
