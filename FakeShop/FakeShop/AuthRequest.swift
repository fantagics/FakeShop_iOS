//
//  SignUpRequest.swift
//  FakeShop
//
//  Created by 이태형 on 1/16/25.
//

import UIKit
import Alamofire

class AuthRequest{
    static func signUp(_ data: [String], completion: @escaping (Result<SignUpRes,Error>)->Void){
        guard data.count == 7 else{return}
        var request = URLRequest(url: URL.signUpUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        let nameParam: [String:String] = ["firstname" : data[2], "lastname" : data[3]]
        let geoParam: [String:String] = ["lat":"-37", "long":"81"]
        let addressParam: [String:Any] = ["city":"kilcoole",
                                          "street":data[5],
                                          "number":3,
                                          "zipcode":"12926-3874",
                                          "geolocation":geoParam
        ]
        let params: [String:Any] = [ "username" : data[0],
                                    "password" : data[1],
                                    "name" : nameParam,
                                    "email" : data[4],
                                    "address" : addressParam,
                                    "phone" : data[6],
        ] as Dictionary
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error:", #function)
        }
        
        AF.request(request).responseDecodable(of: SignUpRes.self){res in
            switch res.result{
            case .success(let data):
                completion(.success(data))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    static func logIn(_ id: String, _ pw: String, completion: @escaping (Result<UserToken,Error>)->Void){
        var request = URLRequest(url: URL.logInUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        let params = [
//            "username": id,
//            "password": pw,
            "username": "mor_2314",
            "password": "83r5^_",
        ] as Dictionary
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error:", #function)
        }
        
        AF.request(request).responseDecodable(of: UserToken.self){res in
            print(res.response?.statusCode) //401: wrong params
            switch res.result{
            case .success(let data):
                completion(.success(data))
            case .failure(let err):
                completion(.failure(err))
            }
        }
        
    }
    
}
