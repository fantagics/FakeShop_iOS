//
//  ProductRequest.swift
//  FakeShop
//
//  Created by 이태형 on 2/2/25.
//

import UIKit
import Alamofire

class ProductRequest{
    
    static func categories(completion: @escaping (Result<[String], Error>)-> Void){
        AF.request(URL.categoriesUrl,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
        .validate(statusCode: 200..<300)
        .responseDecodable(of: [String].self){ res in
            switch res.result{
            case .success(let data):
                completion(.success(data))
            case .failure(let err):
                completion(.failure(err))
            }
            
        }
    }
}
